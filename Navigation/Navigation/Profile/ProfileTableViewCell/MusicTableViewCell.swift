//
//  MusicTableViewCell.swift
//  Navigation
//
//  Created by Sokolov on 24.12.2022.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.text = NSLocalizedString("profile_music_title", comment: "")
        title.textColor = .systemBlue
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "music.note.tv")
        image.tintColor = .systemBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.image)
        
        NSLayoutConstraint.activate([
            self.title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.title.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            
            self.image.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.image.leftAnchor.constraint(equalTo: self.title.rightAnchor, constant: 5)
        
        ])
    }
    
}
