//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sokolov on 23.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0 , y: 0, width: 150, height: 150))
        button.setImage(UIImage(systemName: "p.circle"), for: .normal)
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(self.button)
        self.button.center = self.view.center
        
    }
    
    @objc private func buttonAction() {
        
        let postViewController = PostViewController()
        
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
