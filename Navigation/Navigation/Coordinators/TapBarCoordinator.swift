//
//  TapBarCoordinator.swift
//  Navigation
//
//  Created by Sokolov on 07.12.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {}
}
