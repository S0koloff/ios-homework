//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Sokolov on 24.02.2023.
//

import Foundation
import UIKit
import LocalAuthentication

final class LocalAuthorizationService {
    
    func checkAvailability() -> Bool {
        
        let context = LAContext()
        var error: NSError?
        
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        if let error = error {
            print(error)
            return false
        } else {
            return true
        }
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        
        let context = LAContext()
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Авторизируйтесь для входа") {  success, error in
                if let error = error {
                    print(error)
                    authorizationFinished(false)
                }
                
                if success {
                    authorizationFinished(success)
                }
//            }
        }
    }
}
