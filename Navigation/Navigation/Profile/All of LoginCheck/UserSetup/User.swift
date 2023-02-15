//
//  User.swift
//  Navigation
//
//  Created by Sokolov on 19.11.2022.
//

import UIKit

class User {
    
    var email: String
    var password: String
    var name: String
    var image: UIImage
    var label: String
    
    init(email: String, password: String, name: String, image: UIImage, label: String) {
        self.email = email
        self.password = password
        self.name = name
        self.image = image
        self.label = label
    }
}
