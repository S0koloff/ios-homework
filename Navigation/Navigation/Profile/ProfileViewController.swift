//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Sokolov on 28.08.2022.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    private var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.backgroundColor = .systemGray6
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.insetsLayoutMarginsFromSafeArea = true
        
        return profileHeaderView
    }()
    
    private let profile = Profile(name: "Sad Cat", label: "Waiting for something...")
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 600, height: 1000)
        scrollView.contentSize = CGSize(width: 600, height: 600)
        return scrollView
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        if scrollView == self.scrollView {
            if yOffset >= scrollView.contentSize.height{
            }
        }
        
        if scrollView == self.tableView {
            if yOffset <= 0 {

            }
        }

    }
    
}
    
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.count
        
    }
            

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {

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

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 150
        } else {
        return 600
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
      let destination = PhotosViewController()
      navigationController?.pushViewController(destination, animated: true)
    }
    }
    
}







    
    

