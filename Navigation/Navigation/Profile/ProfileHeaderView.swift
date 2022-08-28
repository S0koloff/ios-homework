//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Sokolov on 27.08.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 36, width: 126, height: 126))
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 162, y: 47, width: 188, height: 42))
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 162, y: 107, width: 212, height: 44))
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 178, width: 373, height: 49))
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
    }
    
    func setup(with profile: Profile) {
        self.avatarImage.image = profile.image
        self.nameLabel.text = profile.name
        self.statusLabel.text = profile.label
    }
    
    @objc private func buttonAction() {
        print(statusLabel.text!)
    }
        
}
