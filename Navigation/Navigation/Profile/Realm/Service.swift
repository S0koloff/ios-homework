//
//  Service.swift
//  Navigation
//
//  Created by Sokolov on 19.01.2023.
//

import Foundation
import RealmSwift

class Service {
    
    let realm = try! Realm()
    
    func createProfile(login: String, password: String, authorization: Bool) {
        
        let profileDate = ProfileDate()
        
        profileDate.login = login
        profileDate.password = password
        profileDate.authorization = authorization
        
        try! realm.write({
            realm.add(profileDate)
        })
    }
}
