//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Sokolov on 16.01.2023.
//

import UIKit
import KeychainAccess

final class SettingsViewController: UIViewController {
    
    private var tableVcDelegate: TableViewController?
    
    private let keychain = Keychain(service: "FileManager.password.token")
    
    @IBOutlet private weak var changePasssButton: UIButton!
    
    @IBOutlet private weak var sortSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "sortValues") {
            sortSwitch.setOn(true, animated: false)
        } else {
            sortSwitch.setOn(false, animated: false)
        }
        
        sortSwitch.addTarget(self, action: #selector(sortSwitchAction), for: .valueChanged)
    }
    
    @IBAction func sortSwitchAction(_ sender: Any) {
        
        if sortSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "sortValues")
            print("Sort enabled")
        } else {
            UserDefaults.standard.set(false, forKey: "sortValues")
            print("Sort disabled")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "settingsUpdate"), object: nil)
        
    }
    
    @IBAction func changePassAction(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Change password", message: "Enter a new password", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in }
        alert.addAction(cancel)
        
        alert.addTextField { field in
            field.placeholder = "Enter a new password"
        }
            
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            guard let field = alert.textFields else {
                return
            }

            let newpassField = field[0]
            
            guard let newpass = newpassField.text, !newpass.isEmpty else {
                return
            }
            
            if newpass.count >= 4 {
                
                do {
                    try self.keychain.set(newpass, key: "password")
                    let alert = UIAlertController(title: "Success!", message: "New password saved", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            } else {
                let alert = UIAlertController(title: "Password must be 4 symbols or more", message: "Try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
        
        alert.addAction(save)

        self.present(alert, animated:true, completion: nil)
        
    }

}
