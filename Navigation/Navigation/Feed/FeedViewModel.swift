//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//

import UIKit


final class FeedViewModel {
    
    var secretWord = "1"
    var correctWord = false
    
    func buttonCheckPressed(word: String) {
        if word == secretWord {
            correctWord = true
        } else {
            correctWord = false
        }
    }
}
