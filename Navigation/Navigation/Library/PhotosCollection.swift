//
//  PhotosCollection.swift
//  Navigation
//
//  Created by Sokolov on 14.11.2022.
//

import UIKit

final class Photos {
    
    static let shared = Photos()
    
    let examples: [UIImage]
    
    private init() {
        var photos = [UIImage]()
        for i in 1...20 { photos.append((UIImage(named: "p\(i)") ?? UIImage())) }
        examples = photos
    }
}

