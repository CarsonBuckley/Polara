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
    var state: String
    var coordinates: String
//    var LatLong: Location___ https://teamtreehouse.com/community/it-keeps-saying-cannot-convert-value-of-type-doubletype-to-expected-argument-type-double-and-same-for-string
//    var latitude: Double
//    var longitude: Double
    var elevation: String
    var acres: String
    var trails: String
    var address: String
    var phoneNumber: String
    var website: String
    var websiteNameFormat: String
    var mapURL: String
}

struct Location {
    let latitude: Double
    let longitude: Double
}

struct Temperature: Codable {
    let temperature: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature"
    }
}
