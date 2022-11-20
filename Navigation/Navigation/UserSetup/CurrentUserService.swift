//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Sokolov on 19.11.2022.
//

import UIKit

class CurrentUserService: UserService {
    
    var user: User?
    
    func check(login: String) -> User? {
        if login == userAlex.login {
            return userAlex
        } else {
            return  user
        }
    }
}
