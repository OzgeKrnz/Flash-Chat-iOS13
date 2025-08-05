//
//  AuthenticationService.swift
//  Flash Chat iOS13
//
//  Created by özge kurnaz on 5.08.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

protocol AuthenticationServicing{
    func signOut(completion: @escaping (Error?)-> Void)
    func getCurrentUSerEmail()->String?
    func signInWithEmail()
}


class AuthenticationService: AuthenticationServicing{
   
    private let auth = Auth.auth()
    
    func signOut(completion: @escaping (Error?) ->Void) {
        do {
            try auth.signOut()
            completion(nil) // Başarılı, hata yok.
        } catch let error {
            print("Error signing out: %@", error)
            completion(error) // Başarısız, hatayı bildir.
        }
    }
    
    func getCurrentUSerEmail() -> String? {
        return auth.currentUser?.email
    }
    
    func signInWithEmail() {
        print("email ile giriş")
    }
}
