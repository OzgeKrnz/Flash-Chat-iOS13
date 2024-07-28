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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title  = "⚡️FlashChat"
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
