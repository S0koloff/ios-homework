//
//  InfoViewController.swift
//  Navigation
//
//  Created by Sokolov on 24.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var arrayOfPeoples = [String]()
    var namesP = [String]()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 105, y: 650, width: 200, height: 50))
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("Close Info", for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 100, y: 20, width: 200, height: 50))
        return titleLabel
    }()
    
    private lazy var orbitalLabel: UILabel = {
        let orbitalLabel = UILabel(frame: CGRect(x: 13, y: 50, width: 379, height: 50))
        orbitalLabel.numberOfLines = 0
        orbitalLabel.font = orbitalLabel.font.withSize(15)
        return orbitalLabel
    }()
    
    private lazy var tableTitleLabel: UILabel = {
        let tableTitleLabel = UILabel(frame: CGRect(x: 13, y: 100, width: 379, height: 50))
        tableTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        return tableTitleLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 16, y: 140 , width: 362, height: 450), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NamesTableViewCell.self, forCellReuseIdentifier: "NamesCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.orbitalLabel)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.tableTitleLabel)
        
 
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
                self.orbitalLabel.text = "Период обращения планеты Татуин вокруг своей звезды: \(planet!.orbital_period)"
                self.tableTitleLabel.text = "Жители планеты \(planet!.name)"
            }
        }
        
        planetDateConfig() { planet, errorText in
            DispatchQueue.main.sync {
                
                planet?.residents.forEach { peoples in
                    self.arrayOfPeoples.append(peoples)
                }

                    for urls in self.arrayOfPeoples {
                        peopleDateConfig(for: urls) { peoplesOnPlanet, textError in
                            DispatchQueue.main.async {
                                self.namesP.append(peoplesOnPlanet?.name ?? "Loading...")
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                
//                for urls in planet!.residents {
//                    peopleDateConfig(for: urls) { peoplesOnPlanet, textError in
//                        DispatchQueue.main.async {
//                            self.namesP.append(peoplesOnPlanet?.name)
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//            }
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

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesP.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NamesCell", for: indexPath) as! NamesTableViewCell
        
        cell.setup(names: namesP[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


