//
//  Resort.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation

struct Resort: Codable {
    
    var name: String
    var location: String
    var coordinates: String
    var temperature: Int
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case location = "location"
        case coordinates = "geocode"
        case temperature = "temperature"
    }
    
//    init(name: String, location: String, temperature: Int) {
//        self.name = name
//        self.location = location
//        self.temperature = temperature
//    }
}

struct ResortTopLevelDictionary: Codable {
    let results: [Resort]
}
