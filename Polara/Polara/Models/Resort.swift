//
//  Resort.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation

struct Resort {
    
    //accuweather.com <--------------------- Better API then openweather
    //http://dataservice.accuweather.com/currentconditions/v1/{location_key}
    //API Key: OQjawqq2DGGmIeopDs9maDXZrntqhL7i
    
    //openweathermap.org
    //http://api.openweathermap.org/data/2.5/weather?lat=40&lon=111&units=imperial&APPID=a3e27dbfd845c20f7ea98fc63be1300d
    //______________________________________________[Coordinates ↑]______________________________________________________
    
    var name: String
    var location: String
    var temperature: Int
    
    init(name: String, location: String, temperature: Int) {
        self.name = name
        self.location = location
        self.temperature = temperature
    }
}
