//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Sokolov on 23.09.2022.
//

import UIKit
import StorageService

public class PostTableViewCell: UITableViewCell {
    
    let newsCoreData = FavoriteNewsDataManager.shared
    var indexPatch: IndexPath!
    
    var id = ""
    var imageName = ""
    
    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var subTextLabel: UILabel = {
        let subTextLabel = UILabel()
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subTextLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subTextLabel.textColor = .systemGray
        subTextLabel.numberOfLines = 0
        return subTextLabel
    }()
    
    private lazy var likeLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        return likeLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewsLabel
    }()
    
    private lazy var addedFavorite: UILabel = {
        let addedFavorite = UILabel()
        addedFavorite.text = "Added to favorite ✓"
        addedFavorite.textColor = .systemGray2
        addedFavorite.font = UIFont.systemFont(ofSize: 13)
        addedFavorite.isHidden = true
        addedFavorite.translatesAutoresizingMaskIntoConstraints = false
        return addedFavorite
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with post: Post) {
        self.id = post.id
        self.myImageView.image = UIImage(named: post.image)
        self.imageName = post.image
        self.titleLabel.text = post.title
        self.subTextLabel.text = post.text
        self.likeLabel.text = post.likes
        self.viewsLabel.text = post.views
        
    }

        @objc func doubleTapFunc() {
            
            print("ID of this news: \(String(describing: id))")
            
            if let _ = newsCoreData.news.firstIndex(where: { $0.id == self.id })  {
                
                print("News already on favorite")
                
            }else {
                
                newsCoreData.createNews(id: id, title: titleLabel.text!, image: imageName, text: titleLabel.text!, likes: likeLabel.text!, views: viewsLabel.text!)
                newsCoreData.reloadNews()
                
                self.addedFavorite.isHidden = false
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newsUpdate"), object: nil)
            }
    }
    
    func changeText(_ text: String) {
        self.titleLabel.text = text
    }
    
    private func setupView() {
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapFunc))
                doubleTap.numberOfTapsRequired = 2
                self.addGestureRecognizer(doubleTap)
        
        
        self.contentView.addSubview(self.myImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subTextLabel)
        self.contentView.addSubview(self.likeLabel)
        self.contentView.addSubview(self.viewsLabel)
        self.contentView.addSubview(self.addedFavorite)
    
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            
            self.addedFavorite.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19),
            self.addedFavorite.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 20),
            self.addedFavorite.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -15),
            
            self.myImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 52),
            self.myImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.myImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.myImageView.bottomAnchor.constraint(equalTo: self.subTextLabel.topAnchor, constant: -16),
            
            
            self.subTextLabel.topAnchor.constraint(equalTo: self.myImageView.bottomAnchor, constant: 16),
            self.subTextLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            self.subTextLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            self.subTextLabel.bottomAnchor.constraint(equalTo: self.likeLabel.topAnchor, constant: -16),
            
            
            self.likeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.likeLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            
            
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.viewsLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)
            
        ])
    }
}
