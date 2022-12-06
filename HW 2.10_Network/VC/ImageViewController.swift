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
        
        DispatchQueue.global().async {
           
            guard let data = NetworkManager.shared.fetchImage(from: self.) else {return}
    
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data)
            self.activityIndicator.stopAnimating()
        }
        }
        
        
        /*DispatchQueue.global().async {
            guard let imageData = NetworkManager.shared.fetchImage(from: self.character.image ) else {return}
        }*/
       // fetchImage()
    }

  /*  private func fetchImage() {
        // создаем экземпляр класса URL
        guard let url = URL(string: Link.imageURL.rawValue) else {return}
        
        // создаем сетевой запрос
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no error description")
                return
            }
            
            guard let image = UIImage(data: data) else {return}
            
            // !!!!После того, как нам станут досупны данные надо перейти из фонового потока в основной!!!ассинхронное исполнение задач!
               DispatchQueue.main.async {
               self.imageView.image = image
               self.activityIndicator.stopAnimating()
            }
            
        }.resume() // !!!!! иначе ничего не заработает!!!!!
        
    }*/
    
    
    
    
}

