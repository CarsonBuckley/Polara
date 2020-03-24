//
//  ResortController.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation
import Firebase

class ResortController {
    
    //Singleton
    static let sharedInstance = ResortController()
    
    //Base URL
    static let baseURL = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/")
    
    //Private init
    private init() {
        self.resorts = createAllResorts()
    }
    
    //Source of Truth
    var resorts: [Resort] = []
    
    func createAllResorts() -> [Resort] {
        var resorts: [Resort] = []
        for (index, resortName) in ResortController.resortNames.enumerated() {
            let location = ResortController.resortLocations[index]
            let temperature = ResortController.resortTemperature
            let resort = Resort(name: resortName, location: location, temperature: temperature)
            resorts.append(resort)
        }
        return resorts
    }
    
    //Probably need to redo the parameters - Quick guess before taking a nap
    func fetchTemperature(location: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    //Static Properties
    static let resortNames = ["Alta", "Beaver Mountain", "Brian Head", "Brighton", "Cherry Peak", "Deer Valley", "Eagle Point", "Nordic Valley", "Park City", "Powder Mountain", "Snowbasin", "Snowbird", "Solitude", "Sundance"]
    
    static let resortLocations = ["Alta", "Garden City", "Brian Head", "Brighton", "Richmond", "Park City", "Beaver", "Eden", "Park City", "Eden", "Snowbasin", "Snowbird", "Solitude", "Sundance"]
    
    static let resortCoordinates = [40.5883 : -111.6358, 41.9681 : -111.5441, 37.7021 : -112.8499, 40.5980 : -111.5832, 41.9263 : -111.7564, 40.6374 : -111.4783, 38.3203 : -112.3839, 41.3104 : -111.8648, 40.6461 : -111.4980, 41.3790 : -111.7807, 41.2160 : -111.8569, 40.5829 : -111.6556, 40.6199 : -111.5919, 40.3934 : -111.5888]
    
    static let resortTemperature = 32
}
