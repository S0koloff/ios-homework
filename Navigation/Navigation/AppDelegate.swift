//
//  AppDelegate.swift
//  Navigation
//
//  Created by Sokolov on 23.08.2022.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import RealmSwift
import KeychainAccess

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let keychain = Keychain(service: "ForRealm.token")
        
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            _ = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) })
        
        keychain[data:"secret"] = key
        
        let secretData = keychain[data: "secret"]
        
        print("KEY: ", key)
        print("SECRET DATA: ", secretData!)
        
        var config = Realm.Configuration(encryptionKey: secretData ) //без обертывания в кейчейн, все ок
        
        config.schemaVersion = 3
        Realm.Configuration.defaultConfiguration = config
                
        do {
            
            _ = try Realm(configuration: config)
            
        } catch let error as NSError {

            fatalError("Error opening realm: \(error)")
        }
                
        
//        let config = Realm.Configuration(schemaVersion: 2)
//        Realm.Configuration.defaultConfiguration = config

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    


}

