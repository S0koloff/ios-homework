//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Sokolov on 28.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 70, width: 414, height: 896))
        profileHeaderView.backgroundColor = .lightGray
        return profileHeaderView
    }()
    
    private let profile = Profile(name: "Sad Cat", label: "Waiting for something...")


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Profile"
        self.view.addSubview(self.profileHeaderView)
        self.profileHeaderView.setup(with: self.profile)
        self.navigationController?.navigationBar.backgroundColor = .white
        
    }
}
