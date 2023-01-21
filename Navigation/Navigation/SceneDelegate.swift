//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Sokolov on 23.08.2022.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
        
    let feedViewController = UINavigationController(rootViewController: FeedViewController())
    
    let profileViewController = UINavigationController(rootViewController: LogInViewController())
    
    let favoriteNewsViewController = UINavigationController(rootViewController: FavoriteNewsViewController())

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.viewControllers = [profileViewController, feedViewController, favoriteNewsViewController]
        
        profileViewController.tabBarItem.title = "Profile"
        feedViewController.tabBarItem.title = "Feed"
        favoriteNewsViewController.tabBarItem.title = "Favorite News"
        
        profileViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        feedViewController.tabBarItem.image = UIImage(systemName: "square.fill.text.grid.1x2")
        favoriteNewsViewController.tabBarItem.image = UIImage(systemName: "text.badge.star")
        
//        tabBarController.viewControllers?.enumerated().forEach {
//            $1.tabBarItem.title = $0 == 0 ? "Profile" : "Feed"
//            $1.tabBarItem.image = $0 == 0
//            ? UIImage(systemName: "person.circle")
//            : UIImage(systemName: "textbox")
//        }
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        let factory = MyLoginFactory()
        let loginInspector = factory.makeLoginInspector()
        let loginVC = LogInViewController()
        loginVC.loginDelegate = loginInspector
        
        let randomeValueforAPI = AppConfiguration.allCases.randomElement()!
        
        NetworkManager.request(for: randomeValueforAPI)
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        try? Auth.auth().signOut()
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
