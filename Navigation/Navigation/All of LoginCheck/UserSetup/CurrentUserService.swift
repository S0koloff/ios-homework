//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Sokolov on 19.11.2022.
//

import UIKit

class CurrentUserService: UserService {
    
    let user = User(login: "alex", name: "Alex", image: UIImage(named: "p6")!, label: "Im very tired")

    func checkService(login: String) -> User? {
        login == user.login ? user : nil
    }
}
