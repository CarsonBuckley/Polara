# Polara
Personal project to track skiing and snowboarding trips with your friends

<img align="right" height="100" src="https://user-images.githubusercontent.com/45154466/88511070-705c4180-cfa1-11ea-8f29-eeefdbfe6e5e.png">
<img align="left" height="700" src="https://user-images.githubusercontent.com/45154466/88511206-b1545600-cfa1-11ea-8ec0-23561c068b31.png">
<img align="left" height="700" src="https://user-images.githubusercontent.com/45154466/88511203-b0232900-cfa1-11ea-9560-86c4da768c9d.png">



Below is the function I wrote to fetch temperatures for ski resorts based off of their coordinates. The above screenshots are how I visually displayed the data to the user after calling the function for each View Controller.

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
