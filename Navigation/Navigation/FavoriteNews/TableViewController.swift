//
//  TableViewController.swift
//  Navigation
//
//  Created by Sokolov on 20.01.2023.
//

import UIKit
import CoreData

class FavoriteNewsViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var newsCoreData = FavoriteNewsDataManager.shared
    
    var index: IndexPath?
    
    var news: [News] = []
    
    var fetchResultController: NSFetchedResultsController = {
        let fecthRequest = News.fetchRequest()
        fecthRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fecthRequest, managedObjectContext: FavoriteNewsDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            self.tableView.reloadData()
        }
    }

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
            
            fetchResultController.delegate = self
            try? fetchResultController.performFetch()
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
        
        let save = UIAlertAction(title: "Search", style: .default) { action in
            var predicate: NSPredicate?
            let textField = alert.textFields?[0]
            if let searchText = textField?.text, searchText.count > 0 {
                predicate = NSPredicate(format: "title contains[cd] %@", searchText)
                         } else {
                             predicate = nil
                         }
                     
         
            self.fetchResultController.fetchRequest.predicate = predicate
                     do {
                         try self.fetchResultController.performFetch()
                         self.tableView.reloadData()
                     } catch let err {
                         print(err)
                     }

        }
        
        alert.addAction(save)
        self.present(alert, animated:true, completion: nil)
        
    }
    
    @objc func clearButtonAction() {
        self.fetchResultController.fetchRequest.predicate = nil
        do {
            try? fetchResultController.performFetch()
            self.tableView.reloadData()
        }
    }

}

extension FavoriteNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return fetchResultController.sections?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.setup(with: fetchResultController.object(at: indexPath))
//        cell.setup(with: news[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DispatchQueue.main.async {
                let post = self.fetchResultController.object(at: indexPath)
                FavoriteNewsDataManager.shared.persistentContainer.viewContext.delete(post)
//                FavoriteNewsDataManager.shared.deleteNews(news: post)
                FavoriteNewsDataManager.shared.saveContext()
                FavoriteNewsDataManager.shared.reloadNews()
//                self.news = self.newsCoreData.getNews(searchText: "")
//                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        } 
    }
}

