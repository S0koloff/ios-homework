//
//  AppFActory.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//

import UIKit

final class AppFactory {
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .feed:
            let view = UINavigationController(rootViewController: FeedViewController())
            return Module(moduleType: moduleType, view: view)
        case .login:
            let view = UINavigationController(rootViewController: LogInViewController())
            return Module(moduleType: moduleType, view: view)
        }
    }
}
