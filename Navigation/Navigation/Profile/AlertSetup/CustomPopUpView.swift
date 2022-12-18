//
//  PopUpAlert.swift
//  Navigation
//
//  Created by Sokolov on 18.12.2022.
//

import UIKit
import SwiftEntryKit

final class CustomPopUpView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var starImage: UIImageView = {
        let starImage = UIImageView()
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .systemBlue
        starImage.translatesAutoresizingMaskIntoConstraints = false
        return starImage
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = UIFont.init(name: "Helvetica", size: 13)
        fullNameLabel.numberOfLines = 0
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    private lazy var actionButton = CustomButton(title: "Get", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 6, useShadow: false, action: { self.actionButtonPressed() })
    
    init(image: UIImage, name: String) {
        super.init(frame: UIScreen.main.bounds)
        imageView.image = image
        fullNameLabel.text = name
        
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    @objc func actionButtonPressed() {
        print("PremiumVersion Layout")
    }
    
    func setupConstraints() {
        
        addSubview(imageView)
        addSubview(starImage)
        addSubview(fullNameLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            starImage.topAnchor.constraint(equalTo: topAnchor,constant: 19),
            starImage.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: -9),
       
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            fullNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            fullNameLabel.rightAnchor.constraint(equalTo: actionButton.leftAnchor, constant: -20),

            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            actionButton.heightAnchor.constraint(equalToConstant: 30),
            actionButton.widthAnchor.constraint(equalToConstant: 50),
            
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 21)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true

    }
}

