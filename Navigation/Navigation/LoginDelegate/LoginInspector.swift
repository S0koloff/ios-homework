//
//  LoginInspector.swift
//  Navigation
//
//  Created by Sokolov on 25.11.2022.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(log: String, pass: String) -> Bool {
        log == Checker.shared.login && pass == Checker.shared.password ? true : false
    }

}
