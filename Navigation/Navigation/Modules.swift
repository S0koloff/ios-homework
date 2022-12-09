//
//  Modules.swift
//  Navigation
//
//  Created by Sokolov on 08.12.2022.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    enum ModuleType {
        case login
        case feed
        
    }

    let moduleType: ModuleType
    let view: UIViewController
}

extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .login:
            return UITabBarItem(title: "Login", image: UIImage(systemName: "person.circle"), tag: 0)
        case .feed:
            return UITabBarItem(title: "Feed", image: UIImage(systemName: "textbox"), tag: 1)
        }
    }
}
