//
//  tabBarController.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//

import UIKit

final class AppTabBarCoordinator: Coordinator {

let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let appTabBarController = AppTabBarController()
        appTabBarController.coordinator = self
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 0)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        
        let feedNavigationController = UINavigationController()
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "textbox"), tag: 1)
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        
        appTabBarController.viewControllers = [profileNavigationController,
                                            feedNavigationController]
        
        appTabBarController.modalPresentationStyle = .fullScreen
                navigationController.present(appTabBarController, animated: true, completion: nil)

        coordinate(to: profileCoordinator)
        coordinate(to: feedCoordinator)
    }

}

