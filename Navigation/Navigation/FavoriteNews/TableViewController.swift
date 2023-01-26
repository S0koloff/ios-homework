//
//  TableViewController.swift
//  Navigation
//
//  Created by Sokolov on 20.01.2023.
//

import UIKit
import CoreData

class FavoriteNewsViewController: UIViewController {
    
    var newsCoreData = FavoriteNewsDataManager.shared
    
    var news: [News] = []

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
            setupNavigationBar()
            news = newsCoreData.getNews()
        }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Favorite News"
        let searchButton = createButtom(imageName: "magnifyingglass.circle", selector: #selector(searchButtonAlert))
        let clearButton = createButtom(imageName: "arrowshape.turn.up.left.2.circle", selector: #selector(clearButtonAction))
        navigationItem.rightBarButtonItems = [clearButton, searchButton]
        
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
        DispatchQueue.main.async {
            self.news = self.newsCoreData.getNews()
            self.tableView.reloadData()
        }
    }
    
    @objc func searchButtonAlert() {
        let alert = UIAlertController(title: "Search Author", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in }
        alert.addAction(cancel)
        alert.addTextField { field in
            field.placeholder = "Author..."
        }
    
        let save = UIAlertAction(title: "Search", style: .default) { (alertAction) in
            guard let field = alert.textFields else {
                return
            }
            
            let autor = field[0]
            print(autor.text)
            self.news = FavoriteNewsDataManager.shared.getNews(searchText: autor.text)
            self.tableView.reloadData()
        }
        
        alert.addAction(save)
        self.present(alert, animated:true, completion: nil)
        
    }
    
    @objc func clearButtonAction() {
        
        self.news = FavoriteNewsDataManager.shared.getNews(searchText: "")
        self.tableView.reloadData()
    }

    }

extension FavoriteNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.setup(with: news[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DispatchQueue.main.async {
                let post = FavoriteNewsDataManager.shared.news[indexPath.row]
                FavoriteNewsDataManager.shared.deleteNews(news: post)
                FavoriteNewsDataManager.shared.reloadNews()
                FavoriteNewsDataManager.shared.saveContext()
                self.news = self.newsCoreData.getNews(searchText: "")
                print(self.news)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } 
    }
}

