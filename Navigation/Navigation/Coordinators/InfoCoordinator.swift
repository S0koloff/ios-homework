//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Sokolov on 10.12.2022.
//

import UIKit

final class InfoCoordinator: Coordinator{
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let infoNavigationController = InfoViewController()
        infoNavigationController.coordinator = self
        
        navigationController?.pushViewController(infoNavigationController, animated: true)
    }
}
