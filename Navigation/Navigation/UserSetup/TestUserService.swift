//
//  TestUserService.swift
//  Navigation
//
//  Created by Sokolov on 20.11.2022.
//

import UIKit

class TestUserService: UserService {
    
    let user = User(login: "Test", name: "Test", image: UIImage(named: "p3")!, label: "Test")
    
    func checkService(login: String) -> User? {
        login == user.login ? user : nil
    }
}
