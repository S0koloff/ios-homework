//
//  ViewController.swift
//  FileManager
//
//  Created by Sokolov on 14.01.2023.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passTextField: UITextField!
    
    private var checkFirstPass = ""
    
    private let keychain = Keychain(service: "FileManager.password.token")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(keychain["password"] ?? "Not found keychain")
        
        setupButton()
    }
    
    func setupButton() {
        loginButton.setTitle("Enter password", for: .normal)
    }
    
    func keyChain() {
        
        do {
            try keychain.set(checkFirstPass, key: "password")
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func removeKeyChain() {
        do {
            try keychain.remove("password")
        } catch let error {
            print("error: \(error)")
        }
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        if keychain["password"] == nil {
            
            if checkFirstPass == "" {
                
                print("na4alo1", checkFirstPass)
                
                if passTextField.text!.count < 4 {
                    let alert = UIAlertController(title: "Password must be 4 symbols or more", message: "Try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                    
                } else {
                    
                    checkFirstPass = passTextField.text ?? ""
                    passTextField.text = ""
                    loginButton.setTitle("Repeat password", for: .normal)
                }
                print("konec1", checkFirstPass)
                
            } else {
                
                if passTextField.text != checkFirstPass {
                    loginButton.setTitle("Enter password", for: .normal)
                    checkFirstPass = ""
                    let alert = UIAlertController(title: "Wrong password", message: "Try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                    
                } else {
                    
                    loginButton.setTitle("Enter password", for: .normal)
                    passTextField.text = ""
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                    keyChain()
                }
            }
            
        } else {
            
            if passTextField.text == keychain["password"] {

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            } else {
                
                let alert = UIAlertController(title: "Wrong password", message: "Try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
                passTextField.text = ""
            }
        }
    }
}

