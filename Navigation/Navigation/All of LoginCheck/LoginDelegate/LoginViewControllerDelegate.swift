//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Sokolov on 24.11.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    
    func check(log: String, pass: String) -> Bool
}
