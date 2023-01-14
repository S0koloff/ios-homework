//
//  TableViewController.swift
//  FileManager
//
//  Created by Sokolov on 14.01.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var activivyIndicator: UIActivityIndicatorView!
    
    var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    func checkList() {
        print("Путь:", path)
        print("Cодержимое дериктории:", content)
    }
    
    var content: [String] {
        
        do {
            return try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activivyIndicator.isHidden = true
        
        checkList()

    }

    @IBAction func AddNewImage(_ sender: Any) {
        
        activivyIndicator.startAnimating()
        activivyIndicator.isHidden = false
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
           
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return content.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = content[indexPath.row]
        cell.detailTextLabel?.text = "File"
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pathForDelete = path + "/" + content[indexPath.row]
            try? FileManager.default.removeItem(atPath: pathForDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }

}

extension TableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
            
            let imageName = UUID().uuidString
            let imagePath = URL(fileURLWithPath: path).appendingPathComponent(imageName + ".jpg")
            print("Cсылка на дерикторию:", URL(fileURLWithPath: path))
            print("Ссылка на картинку:", imagePath)
            
            if let jpegData = image?.jpegData(compressionQuality: 1.0) {
                do {
                    try jpegData.write(to: imagePath)
                } catch {
                    let alert = UIAlertController(title: "Error of create", message: error.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Okay", style: .default)
                    alert.addAction(alertAction)
                    present(alert, animated: true)
                }
            }
            activivyIndicator.stopAnimating()
            activivyIndicator.isHidden = true
            tableView.reloadData()
            picker.dismiss(animated: true, completion: nil)
    }
}
