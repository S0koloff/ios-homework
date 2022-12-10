//
//  Coordinatable.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//

import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
