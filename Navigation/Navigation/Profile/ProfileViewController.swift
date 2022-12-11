//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Sokolov on 28.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var profileHeaderView: ProfileHeaderViewTable = {
        let profileHeaderView = ProfileHeaderViewTable(frame: .zero)
        return profileHeaderView
    }()
        
    private var profile = Profile(name: "Sad Cat", label: "Waiting for something...")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(ProfileHeaderViewTable.self, forHeaderFooterViewReuseIdentifier: "TableHeader")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView(frame: .zero)
        avatar.image = user.image
        avatar.isHidden = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(frame: .zero)
        backButton.isHidden = true
        backButton.setImage(UIImage(systemName: "arrowshape.turn.up.backward"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        return backButton
    }()
    
    private var avatarWidthConstraint: NSLayoutConstraint?
    private var avatarHeightConstraint: NSLayoutConstraint?
    private var avatarLeadingConstant: NSLayoutConstraint?
    private var avatarTopConstant: NSLayoutConstraint?

    
    let posts = postSetup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.view.insertSubview(tableView, at: 0)
        self.view.addSubview(self.avatar)
        self.view.addSubview(self.backButton)
        self.profileHeaderView.setup(with: self.profile)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.setupProfileView ()
        self.tabBarController?.tabBar.isHidden = false
        
        #if DEBUG
        view.backgroundColor = .blue
        
        #else
        view.backgroundColor = .white
        
        #endif
    }
    
    private func setupProfileView () {
        
        self.avatarHeightConstraint = self.avatar.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1)
        self.avatarWidthConstraint = self.avatar.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1)
        self.avatarLeadingConstant = self.avatar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        self.avatarTopConstant = self.avatar.topAnchor.constraint(equalTo: self.view.topAnchor)
        
        NSLayoutConstraint.activate([
            
            self.avatarWidthConstraint,
            self.avatarHeightConstraint,
            self.avatarLeadingConstant,
            self.avatarTopConstant,
            
            self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 320),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ].compactMap({$0 }))
    }
    
    func animateAvatar(avatar: UIImageView) {
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.avatarWidthConstraint?.constant = self.view.frame.width
                self.avatarHeightConstraint?.constant = self.view.frame.width
                self.avatarLeadingConstant?.constant = 0
                self.avatarTopConstant?.constant = self.view.frame.width/3
                self.avatar.layer.cornerRadius = 0
                self.avatar.alpha = 1
                self.avatar.isHidden = false
                
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.8) {
                self.backButton.alpha = 1
                self.backButton.isHidden = false
            }
        } completion: { _ in
        }
    }
    
    @objc func backButtonAction() {
        self.avatar.isHidden = true
        self.backButton.isHidden = true
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == .zero {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosViewCell", for: indexPath) as! PhotosTableViewCell
            cell.setup(with: PostHeader())
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
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
            header.profileVC = self
            
            profile.name = user.name
            profile.image = user.image
            profile.label = user.label

            header.setup(with: profile)

            return header
        } else {
            return nil
        }
    }
    
}







    
    

