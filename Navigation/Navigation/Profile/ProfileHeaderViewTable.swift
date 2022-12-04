//
//  ProfileHeaderTable.swift
//  Navigation
//
//  Created by Sokolov on 27.10.2022.
//

import UIKit

class ProfileHeaderViewTable: UITableViewHeaderFooterView {
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
            let statusTextField = UITextField()
        statusTextField.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        statusTextField.layer.cornerRadius = 4
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.gray.cgColor
        statusTextField.placeholder = " Waiting for something..."
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
            return statusTextField
        }()
    
    private lazy var editButton: CustomButton = {
        let button = CustomButton(title: "Show Status", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 4, useShadow: true)
        button.tapAction = { self.buttonAction() }
        
       return button
    }()
    
//    private lazy var editButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
//        button.backgroundColor = .systemBlue
//        button.setTitle("Show Status", for: UIControl.State.normal)
//        button.layer.cornerRadius = 4
//        button.layer.shadowOffset = CGSize(width: 4, height: 4)
//        button.layer.shadowOpacity = 0.7
//        button.layer.shadowRadius = 4
//        button.layer.masksToBounds = false
//        return button
//    }()
    
    
    
    weak var profileVC: ProfileViewController?
    private var initialAvatarFrame = CGRect(x: 16, y: 16, width: 220, height: 220)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupConstraints()
        self.setupTapAvatar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.avatarImage)
        self.addSubview(self.nameLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.statusTextField)
        self.addSubview(self.editButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate ([
        
            self.avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.avatarImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.avatarImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            self.avatarImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.nameLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16),
            
            self.statusLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 6),
            self.statusLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16),
            self.statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16),
            
            
            self.statusTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
            self.statusTextField.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16),
            self.statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.statusTextField.bottomAnchor.constraint(equalTo: editButton.topAnchor, constant: -10),
            
            self.editButton.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 16),
            self.editButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.editButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9)
        ])
        
    }
    
    func setup(with profile: Profile) {
        self.avatarImage.image = profile.image
        self.nameLabel.text = profile.name
        self.statusLabel.text = profile.label
    }
    
    @objc private func buttonAction() {
        statusLabel.text = statusTextField.text
        print(statusLabel.text ?? "No text")
        statusTextField.text = ""
        statusTextField.placeholder = "\(statusLabel.text! + "...")"
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        avatarImage.clipsToBounds = true
    }
    
    func setupTapAvatar() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapAvatarImage(_:)))
        self.avatarImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapAvatarImage(_ sender: UITapGestureRecognizer) {
        self.profileVC?.animateAvatar(avatar: self.avatarImage)
    }
}


