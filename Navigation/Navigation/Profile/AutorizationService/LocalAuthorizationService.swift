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
    
    private let context = LAContext()
    private var error: NSError?

    
    enum BiometricType: String {
           case none
           case touchID
           case faceID
       }
    
    var biometricType: BiometricType {
            guard self.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
                return .none
            }

            if #available(iOS 11.0, *) {
                switch context.biometryType {
                case .none:
                    return .none
                case .touchID:
                    return .touchID
                case .faceID:
                    return .faceID
                @unknown default:
                    return .none
                }
            } else {
                return self.context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) ? .touchID : .none
            }
        }
    
    
    
    func checkAvailability() -> Bool {
        
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

