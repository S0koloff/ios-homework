//
//  TestUserService.swift
//  Navigation
//
//  Created by Sokolov on 20.11.2022.
//

import UIKit

class TestUserService: UserService {
    
    var user: User?
    
    func check(login: String) -> User? {
        if login == userTest.login {
            return userTest
        } else {
            return nil
        }
    }
}
