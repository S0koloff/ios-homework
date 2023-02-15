//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Sokolov on 25.12.2022.
//

import UIKit
import YouTubeiOSPlayerHelper

class YoutubeTableViewCell: UITableViewCell {
        
    let videos = ["oCqkVZVPOe8", "Rgx8dpiPwpA", "sW9npZVpiMI"]
    
    private lazy var playerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        return playerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(id: String) {
            self.playerView.load(withVideoId: id)
    }
    private func setupView() {
        
        self.contentView.backgroundColor = .systemGray6
        
        self.contentView.addSubview(self.playerView)
        
        NSLayoutConstraint.activate([
        
        self.playerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        self.playerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
        self.playerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
        self.playerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

}
