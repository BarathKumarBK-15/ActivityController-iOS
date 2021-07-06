//
//  ViewController.swift
//  SampleProject1
//
//  Created by Barath Ganesh Kumar on 18/05/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
        pictures.sort()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(mainShareTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture",for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailedViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.curr = indexPath.row + 1
            vc.total = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func mainShareTapped() {
        let vc = UIActivityViewController(activityItems: [], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

