//
//  MainViewController.swift
//  HW 2.10_Network
//
//  Created by Anastasia on 16.08.2022.
//

import UIKit


enum UserAction: String, CaseIterable { // подписываем под протокол для реализации массива
    case downloadImage = "Show Image"
    case getInfoAboutOwner = "Owner of Dog"
   // case getImageAlamofire = "Image (Alamofire)"
    case getInfoAboutOwnerAlamofire = "Owner (Alamofire)"
}


class MainViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases // massive
    
    
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
        case .getInfoAboutOwnerAlamofire:
            performSegue(withIdentifier: "showOwnerAlamofire", sender: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showImage" {
            let ownerVC = segue.destination as! InfoAboutOwnerViewController
            switch segue.identifier {
            case "showOwner":
               ownerVC.fetchOwner()
            case "getInfoAboutOwnerAlamofire":
                ownerVC.alamofireGetButtonPressed()
            default: break
            }
            
            
        }
    }
}



// подписываем класс под протокол, чтобы сделать ячейку динамической
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100) // инициализируем
        
    }
}
 
