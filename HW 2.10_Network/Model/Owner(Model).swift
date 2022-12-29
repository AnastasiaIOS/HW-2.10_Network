//
//  Owner(Model).swift
//  HW 2.10_Network
//
//  Created by Anastasia on 20.08.2022.
//

import UIKit

struct ImageDog: Decodable {
    let image: String
}

struct Owner: Decodable {
    let name: String?
    let age: Int?
    let count: Int?
    
    init(name: String, age: Int, count: Int) {
        self.name = name
        self.age = age
        self.count = count
    }
    
    init(ownerData: [String: Any]) {
        name = ownerData["name"] as? String
        age = ownerData["age"] as? Int
        count = ownerData["count"] as? Int
    }
    
    static func getOwners(from value: Any) -> [Owner] {
        guard let ownersData = value as? [String: Any] else { return [] }
        let owners = [Owner(ownerData: ownersData)]
        return owners
        
        
    }
    
}

struct Owner2: Codable {
    let name: String
    let age: String
    let count: String
   
}

