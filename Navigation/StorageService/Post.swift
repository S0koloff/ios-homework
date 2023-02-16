//
//  Post.swift
//  Navigation
//
//  Created by Sokolov on 11.09.2022.
//

import UIKit

var randomNunber = Int.random(in: 1...500)
let localizedNumbers = NSLocalizedString("any_likes", comment: "")
let formatted = String(format: localizedNumbers, randomNunber)

public struct Post {
    public let id = UUID().uuidString
    public let title: String
    public let image: String
    public let text: String
    public let likes: String
    public let views: String?
    
    public init(title: String, image: String, text: String, likes: String, views: String?) {
        self.title = title
        self.image = image
        self.text = text
        self.likes = likes
        self.views = views
    }
}
