//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Sokolov on 27.08.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var lowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.insetsLayoutMarginsFromSafeArea = true
        button.backgroundColor = .systemBlue
        button.setTitle("New button", for: UIControl.State.normal)
        button.layer.masksToBounds = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.avatarImage)
        self.addSubview(self.nameLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.editButton)
        self.addSubview(self.lowButton)
        
        
        let avatarImageConstraints = self.avatarImageConstraints()
        
        NSLayoutConstraint.activate(avatarImageConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints())
        NSLayoutConstraint.activate(statusLabelConstraints())
        NSLayoutConstraint.activate(editButtonConstraints())
        NSLayoutConstraint.activate(lowButtonConstraints())
        
        
    }
    
    func setup(with profile: Profile) {
        self.avatarImage.image = profile.image
        self.nameLabel.text = profile.name
        self.statusLabel.text = profile.label
    }
    
    @objc private func buttonAction() {
        print(statusLabel.text ?? "No text")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
    }
    
    private func avatarImageConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leftConstraint = self.avatarImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        let widthConstraint = self.avatarImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        let heightConstraint = self.avatarImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.125 )
        
        return [topConstraint, leftConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leftConstraint = self.nameLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16)
        let widthConstraint = self.nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.357922)
        let heightConstraint = self.nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.0387812)
        
        return [topConstraint, leftConstraint, widthConstraint, heightConstraint]
    }
    
    private func statusLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.statusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 74)
        let leftConstraint = self.statusLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16)
        let widthConstraint = self.statusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.397922)
        let heightConstraint = self.statusLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.0387812)
        
        return [topConstraint, leftConstraint, widthConstraint, heightConstraint]
    }
    
    private func editButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.editButton.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 16)
        let leftConstraint = self.editButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        let rightConstraint = self.editButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        let heightConstraint = self.editButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.0652447)
        
        return [topConstraint, leftConstraint, rightConstraint, heightConstraint]
    }
    
    private func lowButtonConstraints() -> [NSLayoutConstraint] {
        let bottomConstraint = self.lowButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        let leftConstraint = self.lowButton.leftAnchor.constraint(equalTo: self.leftAnchor)
        let widthConstraint = self.lowButton.widthAnchor.constraint(equalTo: self.widthAnchor)
        let heightConstraint = self.lowButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.0652447)
        
        return [bottomConstraint, leftConstraint, widthConstraint, heightConstraint]
    }
    
}

