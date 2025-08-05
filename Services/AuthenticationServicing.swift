//
//  AuthenticationServicing.swift
//  Flash Chat iOS13
//
//  Created by özge kurnaz on 5.08.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation

protocol AuthenticationServicing{
    func signOut(completion: @escaping (Error?)-> Void)
    func getCurrentUSerEmail()->String?
}
