//
//  TableViewController.swift
//  Navigation
//
//  Created by Sokolov on 20.01.2023.
//

import UIKit
import CoreData

class FavoriteNewsViewController: UIViewController {

        private lazy var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
            tableView.estimatedRowHeight = 55
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        

        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = .white
            
            self.view.addSubview(self.tableView)
            
            NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name(rawValue: "newsUpdate"), object: nil)

            setupView()
        }
        private func setupView() {
            
            NSLayoutConstraint.activate([
                self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55),
                self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    
    @objc func refreshTable() {
        tableView.reloadData()
    }

    }

extension FavoriteNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteNewsDataManager.shared.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.setup(with: FavoriteNewsDataManager.shared.news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}

