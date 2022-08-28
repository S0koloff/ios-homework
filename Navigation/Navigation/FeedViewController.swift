//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sokolov on 23.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 105, y: 750, width: 200, height: 50))
        button.backgroundColor = UIColor.blue
        button.setTitle("Post", for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(self.button)
    }
    
    @objc private func buttonAction() {
        
        let postViewController = PostViewController()
        
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
