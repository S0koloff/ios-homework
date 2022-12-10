//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Sokolov on 10.12.2022.
//

import UIKit

class ProfileCoordinator: Coordinator {

#if DEBUG
        var userService = TestUserService()
#else
        var userService = CurrentUserService()
#endif
    
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let user = userService.user
        
        let profileViewController = ProfileViewController(user: user)
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }

}

