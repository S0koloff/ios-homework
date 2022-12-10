//
//  AppTabBarControllerr.swift
//  Navigation
//
//  Created by Sokolov on 09.12.2022.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.systemBlue
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
    
    var coordinator: AppTabBarCoordinator?
    
}
