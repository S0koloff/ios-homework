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

let userAlex = User(login: "alex", name: "Alex", image: UIImage(named: "p6")!, label: "Im very tired")

let userTest = User(login: "Test", name: "Test", image: UIImage(named: "p3")!, label: "Test")
