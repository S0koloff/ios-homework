//
//  Model.swift
//  Navigation
//
//  Created by Sokolov on 19.01.2023.
//

import Foundation
import RealmSwift

class ProfileDate: Object {
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var login = ""
    @Persisted var password = ""
    @Persisted var authorization = false
    
}
