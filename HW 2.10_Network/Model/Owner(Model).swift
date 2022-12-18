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
    
}

struct Owner2: Codable {
    let name: String
    let age: String
    let count: String
   
}

