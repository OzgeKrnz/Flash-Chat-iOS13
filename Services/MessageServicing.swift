//
//  MessageServicing.swift
//  Flash Chat iOS13
//
//  Created by özge kurnaz on 5.08.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation

protocol MessageServicing{
    func listenForMessage(completion: @escaping (Result<[Message], Error>)->Void)
    func sendMessage(body: String, sender: String, completion: @escaping (Error?)->Void)
}
