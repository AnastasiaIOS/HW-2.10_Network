//
//  ViewController.swift
//  HW 2.10_Network
//
//  Created by Anastasia on 27.07.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
        
    }
    
    private func fetchImage() {
        ImageManager.shared.fetchImage(from: Link.imageURL.rawValue) { result in
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}















