//
//  PostSetup.swift
//  D&D
//
//  Created by Sokolov on 02.03.2023.
//

import UIKit

struct Post {
    let id = UUID().uuidString
    let title: String
    let image: UIImage
    let text: String
    let likes: String
    let views: String?
    
    public init(title: String, image: UIImage, text: String, likes: String, views: String?) {
        self.title = title
        self.image = image
        self.text = text
        self.likes = likes
        self.views = views
    }
}


var postSetup: [Post] = [
    Post(title: "American Natural", image: UIImage(named: "1")!, text: "America's Most Beautiful Natural", likes: "Likes: 23", views: "Views: 232"),
    Post(title: "Norway Natural", image: UIImage(named:"2")!, text: "Norway is a country of natural beauty characterised by deep fjords with carved valleys.", likes: "Likes: 23" ,views: "Views: 513"),
    Post(title: "Turkish seas", image: UIImage(named:"3")!, text: "Turkey is surrounded by four seas, one of them is internal: Marmara Sea, Black Sea, Aegean Sea, Mediterranean.", likes: "Likes: 23",  views: "Views: 188")
    ]
