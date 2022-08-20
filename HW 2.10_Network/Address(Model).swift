//
//  Address(Model).swift
//  HW 2.10_Network
//
//  Created by Anastasia on 20.08.2022.
//

struct Adrress {
    let postCode: Int
    let country: String
    let countryAbbreviation: String
    let places: Places
    
}

struct Places {
    let placeName: String
    let state: String
    let longitude: Double
    let latitude: Double
}
