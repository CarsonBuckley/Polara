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
    static let baseURL = URL(string: "https://api.weather.com/v3/wx/observations/current?geocode=")
    //Example URL
    //https://api.weather.com/v3/wx/observations/current?geocode=41.3790%2C-111.7807&units=e&language=en-US&format=json&apiKey=9d2908c81003444ea908c81003b44ed4
    
    //Private init
    private init() {
        self.resorts = createAllResorts()
    }
    
    //Source of Truth
    var resorts: [Resort] = []
    
    //Static Properties
    //.count = 14
    static let resortNames = ["Alta", "Beaver Mountain", "Brian Head", "Brighton", "Cherry Peak", "Deer Valley", "Eagle Point", "Nordic Valley", "Park City", "Powder Mountain", "Snowbasin", "Snowbird", "Solitude", "Sundance"]
    
    //.count = 14
    static let resortLocations = ["Alta", "Garden City", "Brian Head", "Brighton", "Richmond", "Park City", "Beaver", "Eden", "Park City", "Eden", "Snowbasin", "Snowbird", "Solitude", "Sundance"]
    
    //.count = 14
    //    static let resortCoordinates = ["40.5883" : "-111.6358", "41.9681" : "-111.5441", "37.7021" : "-112.8499", "40.5980" : "-111.5832", "41.9263" : "-111.7564", "40.6374" : "-111.4783", "38.3203" : "-112.3839", "41.3104" : "-111.8648", "40.6461" : "-111.4980", "41.3790" : "-111.7807", "41.2160" : "-111.8569", "40.5829" : "-111.6556", "40.6199" : "-111.5919", "40.3934" : "-111.5888"]
    
    static let resortCoordinates = ["40.5883%2C-111.6358", "41.9681%2C-111.5441", "37.7021%2C-112.8499", "40.5980%2C-111.5832", "41.9263%2C-111.7564", "40.6374%2C-111.4783", "38.3203%2C-112.3839", "41.3104%2C-111.8648", "40.6461%2C-111.4980", "41.3790%2C-111.7807", "41.2160%2C-111.8569", "40.5829%2C-111.6556", "40.6199%2C-111.5919", "40.3934%2C-111.5888"]
    
    static let altaCoordinates = [40.5883, -111.6358]
    static let beaverMountainCoordinates = [41.9681, -111.5441]
    static let brianHeadCoordinates = [37.7021, -112.8499]
    static let brightonCoordinates = [40.5980, -111.5832]
    static let cherryPeakCoordinates = [41.9263, -111.7564]
    static let deerValleyCoordinates = [40.6374, -111.4783]
    static let eaglePointCoordinates = [38.3203, -112.3839]
    static let nordicValleyCoordinates = [41.3104, -111.8648]
    static let parkCityCoordinates = [40.6461, -111.4980]
    static let powderMountainCoordinates = [41.3790, -111.7807]
    static let snowbasinCoordinates = [41.2160, -111.8569]
    static let snowbirdCoordinates = [40.5829, -111.6556]
    static let solitudeCoordinates = [40.6199, -111.5919]
    static let sundanceCoordinates = [40.3934, -111.5888]
    
    //.count = 1
    static let resortLocationsAndCoordinates = [resortLocations : resortCoordinates]
    
    static let resortTemperature = [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45]
    
    func createAllResorts() -> [Resort] {
        var resorts: [Resort] = []
        for (index, resortName) in ResortController.resortNames.enumerated() {
            let location = ResortController.resortLocations[index]
            let coordinates = ResortController.resortCoordinates[index]
            //let locationsAndCoordinates = ResortController.resortLocationsAndCoordinates
            let temperature = ResortController.resortTemperature[index]
            let resort = Resort(name: resortName, location: location, coordinates: coordinates, temperature: temperature)
            resorts.append(resort)
        }
        return resorts
    }
    
    //Probably need to redo the parameters - Quick guess before taking a nap
    //Coordinates in URL: 41.3790%2C-111.7807 [Powder Mountain Coordinates] Completion: Int -> [The Temperature]
    static func fetchTemperature(with coordinates: String, completion: @escaping (Resort?) -> Void) {
        //1. Construct the proper URL/URLRequest
        guard let url = baseURL else { completion(nil) ; return }
        let fullURL = url.appendingPathComponent(coordinates)
        print(fullURL.absoluteString)
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        //2. Call the DataTask (Don't forget to decode and .resume())
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            print("The Data Task just got back with some data")
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function) ❌")
                completion(nil)
                return
            }
            guard let data = data else { return }
            
            do {
                let coordinates = try JSONDecoder().decode(Resort.self, from: data)
                completion(coordinates)
            } catch {
                print("\(error.localizedDescription) \(error) in function: \(#function) ❌")
                completion(nil)
                return
            }
        } .resume()
    }
    //var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
}

