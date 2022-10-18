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
        profileHeaderView.backgroundColor = .systemGray6
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.insetsLayoutMarginsFromSafeArea = true
        return profileHeaderView
    }()
    
    private let profile = Profile(name: "Sad Cat", label: "Waiting for something...")
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = postSetup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Profile"
        self.view.addSubview(self.profileHeaderView)
        self.view.addSubview(self.tableView)
        self.profileHeaderView.setup(with: self.profile)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.setupProfileView ()
    
    }
    
    private func setupProfileView () {
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.profileHeaderView.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.profileHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.profileHeaderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -600),
        ])
    }
    
}
    
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         self.viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomTableViewCell
        
        let post = viewModel[indexPath.row]
        
        cell.setup(with: post)
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }

}




    
    

