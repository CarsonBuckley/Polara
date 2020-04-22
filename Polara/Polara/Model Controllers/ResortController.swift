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
    let baseURL = URL(string: "https://api.weather.com/v3/wx/observations")
    
    //Private init
    private init() {
        self.resorts = createAllResorts()
    }
    
    //Source of Truth
    var resorts: [Resort] = []
    
    //Properties
    let units = "e"
    let language = "en-US"
    let format = "json"
    let apiKey = "9d2908c81003444ea908c81003b44ed4"
    
    //.count = 14
    let resortNames = ["Alta", "Beaver Mountain", "Brian Head", "Brighton", "Cherry Peak", "Deer Valley", "Eagle Point", "Nordic Valley", "Park City", "Powder Mountain", "Snowbasin", "Snowbird", "Solitude", "Sundance"]
    
    //.count = 14
    let resortLocations = ["Alta", "Garden City", "Brian Head", "Brighton", "Richmond", "Park City", "Beaver", "Eden", "Park City", "Eden", "Snowbasin", "Snowbird", "Solitude", "Sundance"]
    
    //.count = 14
    let resortCoordinates = ["40.5883,-111.6358", "41.9681,-111.5441", "37.7021,-112.8499", "40.5980,-111.5832", "41.9263,-111.7564", "40.6374,-111.4783", "38.3203,-112.3839", "41.3104,-111.8648", "40.6461,-111.4980", "41.3790,-111.7807", "41.2160,-111.8569", "40.5829,-111.6556", "40.6199,-111.5919", "40.3934,-111.5888"]
    
    func createAllResorts() -> [Resort] {
        var resorts: [Resort] = []
        for (index, resortName) in resortNames.enumerated() {
            let location = resortLocations[index]
            let coordinates = resortCoordinates[index]
            let resort = Resort(name: resortName, location: location, coordinates: coordinates)
            resorts.append(resort)
        }
        return resorts
    }

    func fetchTemperature(with coordinates: String, units: String, language: String, format: String, apiKey: String, completion: @escaping (Temperature?) -> Void) {
        
        //1. Construct the proper URL/URLRequest
        guard let baseURL = baseURL?.appendingPathComponent("current"),
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { completion(nil) ; return }
        
        let querySearchTermItem = URLQueryItem(name: "geocode", value: coordinates)
        let queryUnits = URLQueryItem(name: "units", value: units)
        let queryLanguage = URLQueryItem(name: "language", value: language)
        let queryFormat = URLQueryItem(name: "format", value: format)
        let queryApiKey = URLQueryItem(name: "apiKey", value: apiKey)
        components.queryItems = [querySearchTermItem, queryUnits, queryLanguage, queryFormat, queryApiKey]
        guard let finalURL = components.url else { completion(nil) ; return }
        print(finalURL.absoluteString)
        
        //2. Call the DataTask - Don't forget to decode and .resume()
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            print("The Data Task just got back with some data")
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function) ❌")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            
            do {
                let temperature = try JSONDecoder().decode(Temperature.self, from: data)
                completion(temperature)
                print(temperature)
            
            } catch {
                print("\(error.localizedDescription) \(error) in function: \(#function) ❌")
                completion(nil)
                return
            }
        } .resume()
    }
}

