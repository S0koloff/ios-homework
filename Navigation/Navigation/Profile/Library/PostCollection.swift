//
//  PostConfig.swift
//  Navigation
//
//  Created by Sokolov on 14.11.2022.
//

import UIKit
import StorageService

let localizedNumbers = NSLocalizedString("any_likes", comment: "")
let array = Array(1...599)

let format = array.map { numbers in
    var formatted = String(format: localizedNumbers, numbers)
    return formatted
}


var postSetup: [Post] = [
    Post(title: "American Natural", image: "1", text: "America's Most Beautiful Natural", likes: format.randomElement() ?? "0", views: "Views: 232"),
    Post(title: "Norway Natural", image: "2", text: "Norway is a country of natural beauty characterised by deep fjords with carved valleys.", likes: format.randomElement() ?? "0" ,views: "Views: 513"),
    Post(title: "Turkish seas", image: "3", text: "Turkey is surrounded by four seas, one of them is internal: Marmara Sea, Black Sea, Aegean Sea, Mediterranean.", likes: format.randomElement() ?? "0",  views: "Views: 188")
    ]
