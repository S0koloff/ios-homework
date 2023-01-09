//
//  SetupRegistrationPopUpView.swift
//  Navigation
//
//  Created by Sokolov on 09.01.2023.
//
//
//import UIKit
//import SwiftEntryKit
//import FirebaseAuth
//
//func setupRegistrationPopUpView() -> EKFormMessageView {
//    
//    let title = EKProperty.LabelContent(text: "Sign Up", style: .init(font: UIFont.systemFont(ofSize: 20), color: .black))
//    
//    let email = EKProperty.LabelContent(text: "Email...", style: .init(font: UIFont.systemFont(ofSize: 13), color: .init(red: 208, green: 208, blue: 208)))
//    let pass = EKProperty.LabelContent(text: "Password...", style: .init(font: UIFont.systemFont(ofSize: 13), color: .init(red: 208, green: 208, blue: 208)))
//
//    
//    let emailTextField = EKProperty.TextFieldContent(placeholder: email, textStyle: .init(font: UIFont.systemFont(ofSize: 15), color: .black))
//    let passTextField = EKProperty.TextFieldContent(placeholder: pass, textStyle: .init(font: UIFont.systemFont(ofSize: 15), color: .black))
//
//    let buttonLabel = EKProperty.LabelContent(text: "Sign Up", style: .init(font: UIFont.systemFont(ofSize: 17), color: .white))
//    let button = EKProperty.ButtonContent(label: buttonLabel, backgroundColor: .init(red: 0, green: 125, blue: 255), highlightedBackgroundColor: .clear) {
//        
//        let checkerService = CheckerService()
//        checkerService.signUp(for: emailTextField.text, and: passTextField.text!) { result in
//            switch result {
//            case .success(let user):
//                let profileViewController = ProfileViewController(user: user)
//                navgationController?.pushViewController(profileViewController, animated: true)
//            case .failure(let error):
//                print("Error of registration", error)
//            }
//        }
//    }
//    
//    let message = EKFormMessageView(with: title, textFieldsContent: [emailTextField, passTextField], buttonContent: button)
//    
//    return message
//}


