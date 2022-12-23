//
//  NetworkManager.swift
//  HW 2.10_Network
//
//  Created by Anastasia on 26.11.2022.
//

import Foundation
import Alamofire

enum Link: String {
    
    case imageURL = "https://random.dog/be32463b-5476-41ab-bc44-37170957ee69.jpg"
    case ownerURL = "https://api.agify.io/?name=bella"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
 /*   func fetchOwner(from url: String?, with completion: @escaping(Owner) -> Void) {
        
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else {return}
        
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
    }*/
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
}

class ImageManager {
    
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    
}





