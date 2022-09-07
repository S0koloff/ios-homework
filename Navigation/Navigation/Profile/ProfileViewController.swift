//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Sokolov on 28.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.backgroundColor = .lightGray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.insetsLayoutMarginsFromSafeArea = true
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
        self.setupHeaderView ()
    }
    
    private func setupHeaderView () {
        NSLayoutConstraint.activate([
            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.profileHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.profileHeaderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

