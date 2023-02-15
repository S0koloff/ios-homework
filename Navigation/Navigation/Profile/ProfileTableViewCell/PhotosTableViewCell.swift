//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Sokolov on 19.10.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var photo1View: UIImageView = {
        let photosView = UIImageView()
        photosView.backgroundColor = .black
        photosView.layer.cornerRadius = 6
        photosView.clipsToBounds = true
        photosView.translatesAutoresizingMaskIntoConstraints = false
        return photosView
    }()
    private lazy var photo2View: UIImageView = {
        let photosView = UIImageView()
        photosView.backgroundColor = .black
        photosView.layer.cornerRadius = 6
        photosView.clipsToBounds = true
        photosView.translatesAutoresizingMaskIntoConstraints = false
        return photosView
    }()
    private lazy var photo3View: UIImageView = {
        let photosView = UIImageView()
        photosView.backgroundColor = .black
        photosView.layer.cornerRadius = 6
        photosView.clipsToBounds = true
        photosView.translatesAutoresizingMaskIntoConstraints = false
        return photosView
    }()
    private lazy var photo4View: UIImageView = {
        let photosView = UIImageView()
        photosView.backgroundColor = .black
        photosView.layer.cornerRadius = 6
        photosView.clipsToBounds = true
        photosView.translatesAutoresizingMaskIntoConstraints = false
        return photosView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with postHeader: PostHeader) {
        self.titleLabel.text = postHeader.title
        self.photo1View.image = postHeader.photo1
        self.photo2View.image = postHeader.photo2
        self.photo3View.image = postHeader.photo3
        self.photo4View.image = postHeader.photo4

    }
    
    private func setupView() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.photo1View)
        self.contentView.addSubview(self.photo2View)
        self.contentView.addSubview(self.photo3View)
        self.contentView.addSubview(self.photo4View)
        self.contentView.addSubview(self.button)
        
        
        NSLayoutConstraint.activate([
            
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12),
            
            self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.button.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12),
            
            self.photo1View.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.22),
            self.photo1View.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12),
            self.photo1View.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.photo1View.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 44),
            
            self.photo2View.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.22),
            self.photo2View.leftAnchor.constraint(equalTo: self.photo1View.rightAnchor, constant: 8),
            self.photo2View.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.photo2View.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 44),
            
            self.photo3View.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.22),
            self.photo3View.leftAnchor.constraint(equalTo: self.photo2View.rightAnchor, constant: 8),
            self.photo3View.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.photo3View.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 44),
            
            self.photo4View.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.22),
            self.photo4View.leftAnchor.constraint(equalTo: self.photo3View.rightAnchor, constant: 8),
            self.photo4View.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.photo4View.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 44),
            
        ])
    }
    
}



