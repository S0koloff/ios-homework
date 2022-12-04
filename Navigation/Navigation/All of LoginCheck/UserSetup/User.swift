//
//  User.swift
//  Navigation
//
//  Created by Sokolov on 19.11.2022.
//

import UIKit

class User {
    
    var login: String
    var name: String
    var image: UIImage
    var label: String
    
    init(login: String, name: String, image: UIImage, label: String) {
        self.login = login
        self.name = name
        self.image = image
        self.label = label
    }
}
