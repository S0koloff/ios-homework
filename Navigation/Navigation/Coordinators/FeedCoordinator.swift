//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//

import UIKit

protocol FeedFlow: AnyObject {
    func coordinateToPost()
}

class FeedCoordinator: Coordinator, FeedFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        
        navigationController?.pushViewController(feedViewController, animated: false)
    }

    func coordinateToPost() {
        let postViewCoordinator = PostCoordinator(navigationController: navigationController!)
        coordinate(to: postViewCoordinator )
    }
}
