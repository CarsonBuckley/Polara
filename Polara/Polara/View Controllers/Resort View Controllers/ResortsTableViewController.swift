//
//  ResortsTableViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import CoreLocation

class ResortsTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    //Source of Truth
    var resorts: [Resort] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //From the CreateTripViewController
    var fromCreateVC: Bool = false
    
//    let locationManager = CLLocationManager()
    //    let userLocation = CLLocation(latitude: lat, longitude: long)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getLocation()
                //guard let resort = resort else { return }
        //        ResortController.sharedInstance.fetchTemperature(with: resort.coordinates, units: ResortController.sharedInstance.units, language: ResortController.sharedInstance.language, format: ResortController.sharedInstance.format, apiKey: ResortController.sharedInstance.apiKey) { (temperature) in
        //                guard let temperature = temperature else { print("Failed to fetch resort temperature ❌") ; return }
        //                self.setTemperatureLabel(temperature)
        //        }
        
        
//        self.locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fromCreateVC == true {
            self.tabBarController?.selectedIndex = 2
            fromCreateVC = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //    func setTemperatureLabel(_ temperature: Temperature) {
    //        DispatchQueue.main.async {
    //            self.temperatureLabel.text = "\(temperature.temperature)°"
    //        }
    //    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResortController.sharedInstance.resorts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height / 5
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resortCell", for: indexPath) as! ResortTableViewCell
        
        let resort = ResortController.sharedInstance.resorts[indexPath.row]
        cell.resortImage.layer.cornerRadius = cell.resortImage.frame.height / 2
        cell.resort = resort
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResortVC" {
            if let destinationVC = segue.destination as? ResortInfoViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let resort = ResortController.sharedInstance.resorts[indexPath.row]
                    destinationVC.resort = resort
                }
            }
        }
    }
    
//    func roundToFive(x: Double) -> Int {
//        return 5 * Int(round(x / 5.0))
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //        if let currentLocation = locations.last {
//        //            print("Current location: \(currentLocation)")
//        //        }
//
//        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        let latitude = locationValue.latitude
//        let longitude = locationValue.longitude
//        print("locations = \(locationValue.latitude) \(locationValue.longitude)")
//
//        func calculateDistance() -> Int {
//
//            let userLocation = CLLocation(latitude: latitude, longitude: longitude)
//            let destinationLocation = CLLocation(latitude: latitude, longitude: longitude)// latitude and longitude from the json file
//            let distance = userLocation.distance(from: destinationLocation)
//
//            return roundToFive(x: distance)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//
//    func getLocation() {
//        // 1
//        let status = CLLocationManager.authorizationStatus()
//        switch status {
//
//        // 2
//        case.notDetermined: locationManager.requestWhenInUseAuthorization()
//            return
//
//        // 3
//        case.denied, .restricted:
//            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(okAction)
//
//            present(alert, animated: true, completion: nil)
//            return
//
//        case.authorizedAlways, .authorizedWhenInUse:
//            break
//
//        @unknown default:
//            print("WTF")
//        }
//
//        // 4
//        locationManager.delegate = self
//        locationManager.startUpdatingLocation()
//    }
}
