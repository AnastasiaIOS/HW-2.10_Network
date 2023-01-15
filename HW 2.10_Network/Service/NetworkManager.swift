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
                let decoder = JSONDecoder()
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
    
            }
        }.resume()
    }
    
  /*  func fetchOwner(from url: String, completion: @escaping(Result<[Owner], NetworkError>) -> Void) {
        guard let url = URL(string: url) else { // пытаемся создать экз-р класса юрл
            completion(.failure(.invalidURL))  // если битый юрл то ошибка
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in // создаем сессию
            guard let data = data else {  // извлекаем дату
                completion(.failure(.noData))  // если не получится извлечь то помещаем туда ноудата
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                
                let type = try JSONDecoder().decode([Owner].self, from: data) // созд экз модели оунер
                DispatchQueue.main.async {  // асинхронно выходим в основной поток
                    completion(.success(type)) // вызыввем комплишн и в сексесс
                }
            } catch {  // ветка, если не получилось создать экз модели
                completion(.failure(.decodingError))
                print(error.localizedDescription)
    
            }
        }.resume()
    }*/
   
    
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<[Owner], NetworkError>) -> Void) {
        AF.request(Link.ownerURL.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let owners = Owner.getOwners(from: value)
                    DispatchQueue.main.async {
                        completion(.success(owners))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
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





