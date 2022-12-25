//
//  VideoViewController.swift
//  Navigation
//
//  Created by Sokolov on 25.12.2022.
//

import UIKit
import YouTubeiOSPlayerHelper

class VideoViewController: UIViewController {
    
    let concurrentQueue = DispatchQueue(label: "App.cuncurrent", qos: .userInteractive, attributes: [.concurrent])

    let videos = ["oCqkVZVPOe8", "Rgx8dpiPwpA", "sW9npZVpiMI"]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(YoutubeTableViewCell.self, forCellReuseIdentifier: "VideosCell")
        tableView.estimatedRowHeight = 55
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.tableView)

        setupView()
        // Do any additional setup after loading the view.
    }
    private func setupView() {
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideosCell", for: indexPath) as! YoutubeTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setup(id: videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
