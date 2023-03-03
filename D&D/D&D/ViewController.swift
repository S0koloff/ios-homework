//
//  ViewController.swift
//  D&D
//
//  Created by Sokolov on 02.03.2023.
//

import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {

    @IBOutlet weak var tableView1: UITableView!
    
    @IBOutlet weak var tableView2: UITableView!
    
    var array1: [Post] = postSetup
    var array2: [Post] = postSetup


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        tableView1.dataSource = self
        tableView2.dataSource = self

        tableView1.dragDelegate = self
        tableView2.dragDelegate = self

        tableView1.dropDelegate = self
        tableView2.dropDelegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return array1.count
        } else {
            return array2.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!

        if tableView == tableView1 {
            cell.imageView?.image = array1[indexPath.row].image
            cell.textLabel?.text = array1[indexPath.row].text
        } else {
            cell.imageView?.image = array1[indexPath.row].image
            cell.textLabel?.text = array1[indexPath.row].text
        }

        return cell
    }


    var tableViewDropping: UITableView?
    var indexPathForDropping: IndexPath?

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let image = (tableView == tableView1) ? array1[indexPath.row].image : array2[indexPath.row].image
        let text = (tableView == tableView1) ? array1[indexPath.row].text : array2[indexPath.row].text

        let itemProviderImage = NSItemProvider(item: image, typeIdentifier: UTType.image.identifier)
        let itemProviderText = NSItemProvider(item: text.data(using: .utf8) as? NSData, typeIdentifier: UTType.plainText.identifier)


        tableViewDropping = tableView
        indexPathForDropping = indexPath

        return [UIDragItem(itemProvider: itemProviderImage), UIDragItem(itemProvider: itemProviderText) ]
    }


    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

        let indexPath: IndexPath


        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        // V1

        _ = coordinator.session.loadObjects(ofClass: NSString.self) { texts in

            if texts.count > 0 {
                if tableView == self.tableView1 {
                    self.array1[indexPath.row].text.insert(texts, at: destinationIndexPath.row)
                }
                if tableView == self.tableView2 {
                    self.array2.insert(array2.text.text[0], at: destinationIndexPath.row)
                }


                if self.tableViewDropping == self.tableView1 {
                    self.array1.remove(at: self.indexPathForDropping!.row)
                    self.tableView1.reloadData()
                }
                if self.tableViewDropping == self.tableView2 {
                    self.array2.remove(at: self.indexPathForDropping!.row)
                    self.tableView2.reloadData()
                }

                self.tableViewDropping =  nil
                self.indexPathForDropping = nil


                tableView.reloadData()
            }
        }
        
        //V2
        
        _ = coordinator.session.loadObjects(ofClass: NSArray.self as! any NSItemProviderReading.Type) { post in

            if post.count > 0 {
                if tableView == self.tableView1 {
                    self.array1.insert(post, at: destinationIndexPath.row)
                }
                if tableView == self.tableView2 {
                    self.array2.insert(array2.text.text[0], at: destinationIndexPath.row)
                }


                if self.tableViewDropping == self.tableView1 {
                    self.array1.remove(at: self.indexPathForDropping!.row)
                    self.tableView1.reloadData()
                }
                if self.tableViewDropping == self.tableView2 {
                    self.array2.remove(at: self.indexPathForDropping!.row)
                    self.tableView2.reloadData()
                }

                self.tableViewDropping =  nil
                self.indexPathForDropping = nil


                tableView.reloadData()
            }
        }

    }

    
}


