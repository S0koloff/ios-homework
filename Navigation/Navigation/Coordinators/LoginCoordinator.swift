//
//  AboutCoordinator.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//


import UIKit

protocol StartFlow: AnyObject {
    func coordinateToTabBar()
}

class LoginCoordinator: Coordinator, StartFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func coordinateToTabBar() {
        let appTabBarCoordinator = AppTabBarCoordinator(navigationController: navigationController)
        coordinate(to: appTabBarCoordinator)
    }
}
