//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Sokolov on 26.11.2022.
//

import Foundation

struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
