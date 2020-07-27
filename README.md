# Polara

Polara is a cloud-enabled app designed to create and track skiing and snowboarding trips with your friends

## Screenshots
<img src="https://user-images.githubusercontent.com/45154466/88515628-3abb5680-cfa9-11ea-8f06-0e973d5bf2b7.png" alt="Resorts Table View" style="float: center; margin-right: 10px;" height="700"/> <img src="https://user-images.githubusercontent.com/45154466/88515758-6fc7a900-cfa9-11ea-9dd3-fdd574d828a3.png" alt="Beaver Creek" style="float: center; margin-right: 10px;" height="700"/>

- Below is the function I wrote to fetch temperatures for ski resorts based off of their coordinates. The above screenshots are how I visually displayed the data to the user after calling the function for each View Controller.

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
