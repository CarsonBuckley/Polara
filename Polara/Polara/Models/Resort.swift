//
//  Resort.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation

struct Resort {
    
    var name: String
    var location: String
    var coordinates: String
    var temperature: String
    
//    enum Temperature: String {
//        case temperature = "temperature"
//    }
//
//    init?(temperature: Resort.Temperature, dictionary: [String: Any]) {
//        if temperature == .temperature {
//
//        guard let temperatureFromDictionary = dictionary["temperature"] as? String else { return nil }
//
//        self.temperature = temperatureFromDictionary
//
//        } else {
//
//        return nil
//        }
//    }
    
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case location = "location"
//        case coordinates = "geocode"
//        case temperature = "temperature"
//    }
    
//    init(name: String, location: String, temperature: Int) {
//        self.name = name
//        self.location = location
//        self.temperature = temperature
//    }
}

//struct ResortTopLevelDictionary: Codable {
//    let results: [Resort]
//}
