//
//  ProfileHeaderTable.swift
//  Navigation
//
//  Created by Sokolov on 27.10.2022.
//

import UIKit
import SnapKit

class ProfileHeaderViewTable: UITableViewHeaderFooterView {
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusTextField.layer.cornerRadius = 4
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.gray.cgColor
        statusTextField.placeholder = " Waiting for something..."
        return statusTextField
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.setTitle("Show Status", for: UIControl.State.normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        return button
    }()
    
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
        
        avatarImage.snp.makeConstraints { maker in
            maker.top.equalTo(self).inset(16)
            maker.left.equalTo(self).inset(16)
            maker.width.height.equalTo(140)
        }

        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(avatarImage).inset(25)
            maker.left.equalTo(avatarImage).inset(156)
        }

        statusLabel.snp.makeConstraints { maker in
            maker.top.equalTo(avatarImage).inset(65)
            maker.left.equalTo(avatarImage).inset(156)
        }
        
        statusTextField.snp.makeConstraints { maker in
            maker.top.equalTo(avatarImage).inset(105)
            maker.left.equalTo(avatarImage).inset(156)
            maker.right.equalTo(self).inset(16)
            maker.bottom.equalTo(editButton).inset(60)
        }
        editButton.snp.makeConstraints { maker in
            maker.top.equalTo(avatarImage).inset(156)
            maker.left.right.equalTo(self).inset(16)
            maker.bottom.equalTo(self).inset(9)
        }
        
    }
    
    func setup(with profile: Profile) {
        self.avatarImage.image = profile.image
        self.nameLabel.text = profile.name
        self.statusLabel.text = profile.label
    }
    
    @objc private func buttonAction() {
        self.statusLabel.text = statusTextField.text
        print(statusLabel.text ?? "No text")
        self.endEditing(true)
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


