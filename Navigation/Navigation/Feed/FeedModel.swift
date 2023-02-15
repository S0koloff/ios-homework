//
//  FeedModel.swift
//  Navigation
//
//  Created by Sokolov on 04.12.2022.
//

import UIKit

class FeedModel {
    
    let secretWord = "1"
    
    func checkWord (word: String) -> Bool {
        word == secretWord ? true : false
    }
}
