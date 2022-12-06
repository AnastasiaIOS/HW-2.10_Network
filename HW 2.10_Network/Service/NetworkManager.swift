//
//  NetworkManager.swift
//  HW 2.10_Network
//
//  Created by Anastasia on 26.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchOwner(from url: String?, with completion: @escaping(Owner) -> Void) {
        
        guard let stringURL = url else { return }
        guard let url = URL(string: Link.ownerURL.rawValue) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            do {
                let owner = try JSONDecoder().decode(Owner.self, from: data) // декодируем полученные от                                                                    сервера данные в экз-р модели
                DispatchQueue.main.async {   // выходим в основной поток
                    completion(owner)        // в complition передаем экемпляр модели
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        } .resume()
    }
}

class ImageManager {
    
    static var shared = ImageManager()
    
    private init() {}
    
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
}

/*
func fetchOwner() {
   
   // создаем URL - адрес
   guard let url = URL(string: Link.ownerURL.rawValue) else {return}
   
   // создаем URL сессию
   URLSession.shared.dataTask(with: url) { data, _, error in
       guard let data = data else {
           print(error?.localizedDescription ?? "No error")
           return
       }
       
       do {
           let owner = try JSONDecoder().decode(Owner.self, from: data)
           DispatchQueue.main.async {
               self.owners.append(owner)
               self.tableView.reloadData()
           }
           
       } catch let error {
           print(error.localizedDescription)
       }
       
   } .resume() // !!!!НЕ ЗАБЫВАТЬ ПРО resume, иначе ничего не сработает
   
}
*/
