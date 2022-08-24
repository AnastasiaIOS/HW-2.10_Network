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
        // создаем экземпляр класса URL
        guard let url = URL(string: Link.imageURL.rawValue) else {return}
        // создаем сетевой запрос
        
        URLSession.shared.dataTask(with: url) { [self] data, _ , error in
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
        
    }
}

