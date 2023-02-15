//
//  CheckerService.swift
//  Navigation
//
//  Created by Sokolov on 08.01.2023.
//

import UIKit
import FirebaseAuth


protocol CheckerServiceProtocol {
    
    func checkCredentials(for email: String, and password: String, completionFor completion: @escaping ((Result<User,Error>) -> Void))
    
    func signUp(for email: String, and password: String, completionFor completion: @escaping ((Result<User,Error>) -> Void))
    
}


class CheckerService: CheckerServiceProtocol {
 
    func checkCredentials(for email: String, and password: String, completionFor completion: @escaping ((Result<User, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil && email == "alex@mail.com" {
                let user = User(email: email, password: password, name: "Alex", image: UIImage(named: "p6")!, label: "Im very tired")
                completion(.success(user))
            } else {
                if error == nil {
                    let user = User(email: email, password: password, name: "New Profile", image: UIImage(named: "newprofile")!, label: "Waiting for something...")
                    completion(.success(user))
                } else {
                    completion(.failure(error!))
                }
            }
        }
    }
    
    func signUp(for email: String, and password: String, completionFor completion: @escaping ((Result<User, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                let user = User(email: email, password: password, name: "New Profile", image: UIImage(named: "newprofile")!, label: "Waiting for something...")
                completion(.success(user))
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    
}
