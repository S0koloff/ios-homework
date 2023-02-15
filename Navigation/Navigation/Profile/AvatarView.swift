//
//  AvatarView.swift
//  Navigation
//
//  Created by Sokolov on 02.11.2022.
//

import UIKit

class AvatarView: UIView {
    
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "cat")
        return avatar
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .blue
        return button
    }()
    
        
}
