//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages : [Message] = [
        Message(sender: "ozge@gmail.com", body: "Selam"),
        Message(sender: "d@gmail.com", body: "Selam"),
        Message(sender: "ozge@gmail.com", body: "Naber")


    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title  = Constants.appName
        // back nav gizleme
        navigationItem.hidesBackButton = true

    }
    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            // pop to route viewcontroller
            navigationController?.popToRootViewController(animated: true)
            print("Cıkıs yapıldı")
        }
        catch let signOutError as NSError{
            print("Error signing out: %@",signOutError)
            
        }
        
    }
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

}

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
    
    
}
