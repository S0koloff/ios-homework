//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Sokolov on 25.12.2022.
//
import UIKit

class VideoTableViewCell: UITableViewCell {
    
    static var background: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
                } else {
                    return UIColor.white
                    
                }
            }
        } else {
            return UIColor.white
        }
    }()
    
    static var text: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.white
                } else {
                    return UIColor.black
                    
                }
            }
        } else {
            return UIColor.white
        }
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.text = NSLocalizedString("profile_video_title", comment: "")
        title.textColor = VideoTableViewCell.text
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "play.rectangle")
        image.tintColor = VideoTableViewCell.text
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
        
        self.contentView.backgroundColor = VideoTableViewCell.background
        
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
