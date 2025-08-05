//
//  AuthenticationService.swift
//  Flash Chat iOS13
//
//  Created by özge kurnaz on 5.08.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation
import Firebase


protocol EmailAuthenticating{
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>)->Void)
}

protocol SignOutServicing{
    func signOut(completion: @escaping (Error?)-> Void)

}

protocol CurrentUserFetching{
    func getCurrentUserEmail()->String?

}

class AuthenticationService: EmailAuthenticating, SignOutServicing, CurrentUserFetching{
 
   
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
    
    func getCurrentUserEmail() -> String? {
        return auth.currentUser?.email
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, any Error>) -> Void) {
        auth.signIn(withEmail: email, password: password)
    }
    
}
