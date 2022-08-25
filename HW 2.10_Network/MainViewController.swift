//
//  MainViewController.swift
//  HW 2.10_Network
//
//  Created by Anastasia on 16.08.2022.
//

import UIKit

enum Link: String {
    case imageURL = "https://random.dog/be32463b-5476-41ab-bc44-37170957ee69.jpg"
    case ownerURL = "https://api.agify.io/?name=bella"
}

enum UserAction: String, CaseIterable { // подписываем под протокол для реализации массива
    case downloadImage = "Download Image of Dog"
    case getInfoAboutOwner = "Owner of Dog"
}


class MainViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases // massive
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "сell", for: indexPath) as! UserActionCell // создается объект ячейки и кастим до типа нашего класса
     
        
        cell.personLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //определяем конкретный кейс и далее по какой ячейке тапнули
        
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "showImage", sender: nil)
        case .getInfoAboutOwner:
            performSegue(withIdentifier: "showOwner", sender: nil)
            print("hello")
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOwner" {
            guard let ownerVC = segue.destination as? OwnerViewController else {return}
            ownerVC.fetchOwner()
        }
    }
}

// подписываем класс под протокол, чтобы сделать ячейку динамической
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100) // инициализируем
        
    }
}

// MARK: - Networking
extension MainViewController {
    private func getInfoAboutOwner() {
        
        // создаем URL - адрес
        guard let url = URL(string: Link.ownerURL.rawValue) else {return}
        
        // создаем URL сессию
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error")
                return
            }

        } .resume() // !!!!НЕ ЗАБЫВАТЬ ПРО resume, иначе ничего не сработает
    }
}

