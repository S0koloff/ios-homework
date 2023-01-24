//
//  Post.swift
//  Navigation
//
//  Created by Sokolov on 11.09.2022.
//

import UIKit

public struct Post {
    public let id = UUID().uuidString
    public let title: String
    public let image: String
    public let text: String
    public let likes: String?
    public let views: String?
    
    public init(title: String, image: String, text: String, likes: String?, views: String?) {
        self.title = title
        self.image = image
        self.text = text
        self.likes = likes
        self.views = views
    }
}
