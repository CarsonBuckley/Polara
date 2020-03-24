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
    var temperature: Int
    
    init(name: String, location: String, temperature: Int) {
        self.name = name
        self.location = location
        self.temperature = temperature
    }
}
