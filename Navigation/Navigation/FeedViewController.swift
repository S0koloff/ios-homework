//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sokolov on 23.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.blue
        button.setTitle("Post", for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(self.button)
        setupView()
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.button.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            self.button.leftAnchor.constraint(equalTo: self.view.rightAnchor,constant: -30),
            self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
        ])
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
