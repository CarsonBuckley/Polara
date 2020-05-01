//
//  ResortInfoViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/15/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SafariServices

class ResortInfoViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var resortImage: UIImageView!
    @IBOutlet weak var resortLocationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var elevationLabel: UILabel!
    @IBOutlet weak var acresLabel: UILabel!
    @IBOutlet weak var trailsLabel: UILabel!
    @IBOutlet weak var mapsButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var createTripButton: UIButton!
    
    var resort: Resort? {
        didSet {
            
        }
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        guard let resort = resort else { return }
        self.navigationItem.title = resort.name//.uppercased()
        resortImage.image = UIImage(named: "\(resort.name) Cover")
        resortImage.layer.cornerRadius = 10
        resortLocationLabel.text = "\(resort.location), \(resort.state)"
        resortLocationLabel.textColor = .white
        distanceLabel.text = "0000 mi"
        elevationLabel.text = "Elevation: \(resort.elevation) ft"
        acresLabel.text = "Skiable: \(resort.acres) acres"
        trailsLabel.text = "Trails: \(resort.trails)"
        mapsButton.layer.cornerRadius = 5
        mapsButton.setTitleColor(.white, for: .normal)
        mapsButton.backgroundColor = .iceBlue
        websiteButton.setTitle("\(resort.websiteNameFormat)", for: .normal)
        createTripButton.layer.cornerRadius = 5
        createTripButton.setTitleColor(.black, for: .normal)
        createTripButton.backgroundColor = .white
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        ResortController.sharedInstance.fetchTemperature(with: resort.coordinates, units: ResortController.sharedInstance.units, language: ResortController.sharedInstance.language, format: ResortController.sharedInstance.format, apiKey: ResortController.sharedInstance.apiKey) { (temperature) in
            guard let temperature = temperature else { print("Failed to fetch resort temperature ❌") ; return }
            self.setTemperatureLabel(temperature)
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }
    
    func setTemperatureLabel(_ temperature: Temperature) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(temperature.temperature)°"
        }
    }
    
    func roundToFive(x: Double) -> Int {
        return 5 * Int(round(x / 5.0))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        if let currentLocation = locations.last {
        //            print("Current location: \(currentLocation)")
        //        }
        
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let latitude = locationValue.latitude
        let longitude = locationValue.longitude
        print("locations = \(locationValue.latitude) \(locationValue.longitude)")
        
        func calculateDistance() -> Int {
            
            let userLocation = CLLocation(latitude: latitude, longitude: longitude)
            let destinationLocation = CLLocation(latitude: latitude, longitude: longitude)// latitude and longitude from the json file
            let distance = userLocation.distance(from: destinationLocation)
            
            return roundToFive(x: distance)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getLocation() {
        // 1
        let status = CLLocationManager.authorizationStatus()
        switch status {
            
        // 2
        case.notDetermined: locationManager.requestWhenInUseAuthorization()
            return
            
        // 3
        case.denied, .restricted:
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
            
        case.authorizedAlways, .authorizedWhenInUse:
            break
            
        @unknown default:
            print("WTF")
        }
        
        // 4
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func openMaps() {
        guard let resort = resort else { return }
        guard let url = URL(string: "\(resort.mapURL)") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(url)
        }
    }
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            //Show an invalid URL error alert
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    //        let location = CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402)
    //        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    //        let region = MKCoordinateRegion(center: location, span: span)
    //        mapView.setRegion(region, animated: true)
    //
    //        let annotation = MKPointAnnotation()
    //        annotation.coordinate = location
    //        annotation.title = "Big Ben"
    //        annotation.subtitle = "London"
    //        mapView.addAnnotation(annotation)
    // Do any additional setup after loading the view.
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateTripVC" {
            if let destinationVC = segue.destination as? CreateTripViewController {
                //if let indexPath = tableView.indexPathForSelectedRow {
                //let resort = ResortController.sharedInstance.resorts[indexPath.row]
                destinationVC.resort = resort
            }
        }
    }
    
    @IBAction func mapsButtonTapped(_ sender: UIButton) {
        openMaps()
    }
    
    @IBAction func websiteButtonTapped(_ sender: UIButton) {
        showSafariVC(for: resort?.website ?? "")
    }
}

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toCreateTripVC" {
//            if let destinationVC = segue.destination as? CreateTripViewController {
////                if let indexPath = tableView.indexPathForSelectedRow {
////                    let resort = ResortController.sharedInstance.resorts[indexPath.row]
////                    destinationVC.resort = resort
////                }
//            }
//        }
//    }

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let currentLocation = locations.last {
//            print("Current location: \(currentLocation)")
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
//        }
//
//        // 4
//        locationManager.delegate = self
//        locationManager.startUpdatingLocation()
//    }


//}
