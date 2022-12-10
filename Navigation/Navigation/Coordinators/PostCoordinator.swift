//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Sokolov on 09.12.2022.
//

import UIKit

protocol PostFlow {
    func coordinateToInfo ()
}

final class PostCoordinator: Coordinator, PostFlow {

    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postNavigationController = PostViewController()
        postNavigationController.coordinator = self
        
        navigationController?.pushViewController(postNavigationController, animated: true)
    }
    
    func coordinateToInfo() {
        let infoViewCoordinator = InfoCoordinator(navigationController: navigationController!)
        coordinate(to: infoViewCoordinator )    }
    
}
