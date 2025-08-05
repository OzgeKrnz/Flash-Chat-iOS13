//
//  MessageService.swift
//  Flash Chat iOS13
//
//  Created by özge kurnaz on 5.08.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

protocol MessageServicing {
    func listenForMessage(completion: @escaping (Result<[Message], Error>) -> Void)
    func sendMessage(body: String, sender: String, completion: @escaping (Error?) -> Void)
}


class MessageService: MessageServicing{
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
     
    ]
    
    func listenForMessage(completion: @escaping (Result<[Message], any Error>) -> Void) {
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
                        }
                     
                    }
                    completion(.success(self.messages))
                }
            }
        }

    }
    
    func sendMessage(body: String, sender: String, completion: @escaping ((any Error)?) -> Void) {
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
                            
                        }
                     
                    }
                }
            }
        }

    }
    
    
}
