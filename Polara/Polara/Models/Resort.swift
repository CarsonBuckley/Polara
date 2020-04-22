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
}

struct Temperature: Codable {
    
    let temperature: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature"
    }
}
