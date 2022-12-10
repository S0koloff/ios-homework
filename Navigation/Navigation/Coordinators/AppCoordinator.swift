//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        
        coordinate(to: loginCoordinator)
    }
}
