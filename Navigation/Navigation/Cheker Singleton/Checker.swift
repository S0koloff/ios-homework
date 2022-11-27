//
//  Checker.swift
//  Navigation
//
//  Created by Sokolov on 24.11.2022.
//

import UIKit

final class Checker {
    
    static let shared = Checker()
    
    let login = "123"
    let password = "123"
    
    private init() {}
    
    func check(log: String, pass: String) -> Bool {
        log == login && pass == password ? true : false
    }
}


