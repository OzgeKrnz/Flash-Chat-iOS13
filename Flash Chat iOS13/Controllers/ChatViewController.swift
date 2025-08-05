//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    // UI
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!
    
    
   
    private let authService: AuthenticationServicing
    private let messageService: MessageServicing
    
    init(authService: AuthenticationServicing = AuthenticationService(), messageService: MessageServicing = MessageService()){
        self.authService = authService
        self.messageService = messageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
//    // srp ihlali db işlemi vc icinde ayrıca dependency inversion ihlali vc alt modüle dogrudan bağlanmış
//    let db = Firestore.firestore()
//    
    var messages: [Message] = []
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = Constants.appName
        // back nav gizleme
        navigationItem.hidesBackButton = true        
        // nıb file
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        loadMessages()
    }
    
    // veri cekme
    func loadMessages(){
        // veritabanından veri cekme srp ihlali
   

        messageService.listenForMessage{ [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let messages):
                self.messages = messages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Mesajlar yüklenemedi: \(error.localizedDescription)")
            }
        }
    }

    @IBAction func logOutButton(_ sender: Any) {
        // srp ihlali: vc icinde firebase işlemi var ayrıca dependency inversion ihlali.
        authService.signOut{[weak self] (error) in
            if error == nil{
                print("çıkış yapıldı")
                self?.navigationController?.popToRootViewController(animated: true)
            }else{
                print("Cıkıs yapılırken hata oluştu: \(error!.localizedDescription)")
            }
        }
    }

    @IBAction func sendPressed(_ sender: UIButton) {
        // save mssg
        
        guard let messageBody = messageTextfield.text, !messageBody.isEmpty,
              let messageSender = authService.getCurrentUSerEmail() else {
            return
        }
        
        messageService.sendMessage(body: messageBody, sender: messageSender){
            [weak self] error in
            if let error = error {
                print("Mesaj gönderilemedi: \(error.localizedDescription)")
            }else{
                DispatchQueue.main.async {
                    self?.messageTextfield.text = ""
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
                cell.label.text = messages[indexPath.row].body
        return cell
    }
}




