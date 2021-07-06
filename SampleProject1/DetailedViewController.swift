//
//  DetailedViewController.swift
//  SampleProject1
//
//  Created by Barath Ganesh Kumar on 29/05/21.
//

import UIKit

class DetailedViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    var total = 0
    var curr = 0
    var shareString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(curr) of \(total)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
            shareString = imageToLoad
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1.0) else {
            print("No image Found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image,shareString], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
