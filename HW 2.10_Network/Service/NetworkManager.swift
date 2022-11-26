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
    
    func fetchData(from url: String?, with completion: @escaping(Owner) -> Void) {
        
        guard let stringURL = url else { return}
        guard let url = URL(string: stringURL) else {return}
        
        
    }
}
