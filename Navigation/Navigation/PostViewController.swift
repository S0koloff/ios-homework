//
//  PostViewController.swift
//  Navigation
//
//  Created by Sokolov on 24.08.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Hello world!"
    
    private func setupViews() {
        createNavigationBar()
        
        let infoButton = createButtom(imageName: "info.circle", selector: #selector(infoButtomTapped))
        
        navigationItem.rightBarButtonItems = [infoButton]
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        self.navigationItem.title = titlePost
        
        setupViews()
    }
    
    @objc private func infoButtomTapped() {
        
        let vc = InfoViewController()
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
    
}
