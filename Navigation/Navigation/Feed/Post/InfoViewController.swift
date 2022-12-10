//
//  InfoViewController.swift
//  Navigation
//
//  Created by Sokolov on 24.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    weak var coordinator: InfoCoordinator?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 105, y: 700, width: 200, height: 50))
        button.backgroundColor = UIColor.blue
        button.setTitle("Close Info", for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        self.view.addSubview(self.closeButton)
    }
    
    @objc private func didTapCloseButton() {
        let alertController = UIAlertController(title: "Close info", message: "Do you wanna close?", preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: "Yes", style: .default) { _ in
            print("YES")
        }
        let secondAction = UIAlertAction(title: "No", style: .destructive) { _ in
            print("NOPE")
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        self.present(alertController, animated: true)
    }
}


