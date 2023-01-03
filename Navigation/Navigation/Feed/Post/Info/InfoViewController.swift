//
//  InfoViewController.swift
//  Navigation
//
//  Created by Sokolov on 24.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var arrayOfPeoples = [String]()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 105, y: 650, width: 200, height: 50))
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("Close Info", for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 105, y: 20, width: 200, height: 50))
        return titleLabel
    }()
    
    private lazy var orbitalLabel: UILabel = {
        let orbitalLabel = UILabel(frame: CGRect(x: 190, y: 50, width: 100, height: 50))
        return orbitalLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 16, y: 110 , width: 362, height: 500), style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.orbitalLabel)
        self.view.addSubview(self.tableView)
        
        makeData()
        
    }
    
    private func makeData() {
        DateConfig.dateConfig() { title in
            DispatchQueue.main.async {
                self.titleLabel.text = title
            }
        }
        
        planetDateConfig() { planet, errorText in
            DispatchQueue.main.async {
                self.orbitalLabel.text = planet?.orbital_period
            }
        }
        
        planetDateConfig() { planet, errorText in
            DispatchQueue.main.sync {
                planet?.residents.forEach { people in
                    self.arrayOfPeoples.append(people)
                }
            }
        }
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


