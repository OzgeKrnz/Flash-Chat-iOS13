//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import Firebase
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
     
    ]
    
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
        
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []

            if let e = error{
                print(e)
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            //tableview ekleme
                            DispatchQueue.main.async{
                                self.tableView.reloadData()

                            }
                            
                        }
                     
                    }
                }
            }
        }
    }

    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // pop to route viewcontroller
            navigationController?.popToRootViewController(animated: true)
            print("Cıkıs yapıldı")
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    @IBAction func sendPressed(_ sender: UIButton) {
        // save mssg
        if let messageBody = messageTextfield.text, let messageSender = 
            Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                    if let e = error{
                        print(e)
                    } else{
                        print("Data saved successfully.")
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
