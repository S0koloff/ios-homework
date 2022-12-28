//
//  LoginFactory.swift
//  Navigation
//
//  Created by Sokolov on 26.11.2022.
//

import Foundation

protocol LoginFactory {
   func  makeLoginInspector () -> LoginInspector
}
