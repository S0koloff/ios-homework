//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Sokolov on 28.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileHeaderView: ProfileHeaderViewTable = {
        let profileHeaderView = ProfileHeaderViewTable(frame: .zero)
//        profileHeaderView.backgroundColor = .systemGray6
//        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
//        profileHeaderView.insetsLayoutMarginsFromSafeArea = true
        
        return profileHeaderView
    }()
    
    private let profile = Profile(name: "Sad Cat", label: "Waiting for something...")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(ProfileHeaderViewTable.self, forHeaderFooterViewReuseIdentifier: "TableHeader")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = postSetup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Profile"
        self.view.addSubview(self.tableView)
        self.profileHeaderView.setup(with: self.profile)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.setupProfileView ()
    }
    
    private func setupProfileView () {
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == .zero {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosViewCell", for: indexPath) as! PhotosTableViewCell
            cell.setup(with: PhotosTableViewCell.PhotosViewModel())
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomTableViewCell
            let post = viewModel[indexPath.row]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setup(with: post)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == .zero {
            return 150
        } else {
            return 600
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let destination = PhotosViewController()
            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeader") as! ProfileHeaderViewTable
            header.setup(with: profile)
            return header
        } else {
            return nil
        }
    }
    
}







    
    

