//
//  Coordinator.swift
//  Navigation
//
//  Created by Sokolov on 07.12.2022.
//

import UIKit

protocol Coordinator: AnyObject {
        
    var childrenCoordinators: [Coordinator] {get}
    
    func start() -> UIViewController
    func addChildCoordinator( coordinator: Coordinator)
    func removeChildCoordinator( coordinator: Coordinator)
}

protocol ModuleCoordinator: Coordinator {
    var module: Module? { get }
    var moduleType: Module.ModuleType {get }
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}
