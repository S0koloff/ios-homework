//
//  UserService.swift
//  Navigation
//
//  Created by Sokolov on 19.11.2022.
//

import UIKit

protocol UserService {
    
    func check(login: String) -> User?
    
}

