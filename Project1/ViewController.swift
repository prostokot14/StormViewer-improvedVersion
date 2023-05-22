//
//  ViewController.swift
//  Project1
//
//  Created by Антон Кашников on 09.02.2023.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        if #available(iOS 14, *) {
            var content = cell.defaultContentConfiguration()
            content.text = pictures[indexPath.row]
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = pictures[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
