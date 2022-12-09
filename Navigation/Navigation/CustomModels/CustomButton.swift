//
//  CustomButton.swift
//  Navigation
//
//  Created by Sokolov on 03.12.2022.
//

import UIKit

final class CustomButton: UIButton {
    
    typealias Action = () -> Void
    
    var title: String
    var titleColor: UIColor
    var backgroundButtonColor: UIColor
    var cornerRadius: CGFloat
    var useShadow: Bool
    
    var tapAction: Action
    
    init(title: String, titleColor: UIColor, backgroundButtonColor: UIColor, cornerRadius: CGFloat, useShadow: Bool, action: @escaping Action)  {
        self.title = title
        self.titleColor = titleColor
        self.backgroundButtonColor = backgroundButtonColor
        self.cornerRadius = cornerRadius
        self.useShadow = useShadow
        self.tapAction = action
        super.init(frame: .zero)
        
        backgroundColor = backgroundButtonColor
        layer.cornerRadius = cornerRadius

        if useShadow == true {
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4
        layer.masksToBounds = false
        }
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setTitle(title, for: .normal)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        tapAction()
    }
    
}
