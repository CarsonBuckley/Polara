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

class ResortInfoViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var resortNameLabel: UILabel!
    @IBOutlet weak var resortLocationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var resortImage: UIImageView!
    @IBOutlet weak var createTripButton: UIButton!
    
    var resort: Resort? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let resort = resort else { return }
        self.navigationItem.title = resort.name.uppercased()
        resortNameLabel.text = resort.name
        resortLocationLabel.text = resort.location + ", UT"
        distanceLabel.isHidden = true
        temperatureLabel.isHidden = true
        //temperatureLabel.text = "\(resort.temperature)°"
        resortImage.image = UIImage(named: resort.name)
        resortImage.layer.cornerRadius = resortImage.frame.height / 2
        createTripButton.layer.cornerRadius = 3
        createTripButton.layer.borderWidth = 1.5
        createTripButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
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
    }
    
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

//extension ResortInfoViewController: MKMapViewDelegate {
//
//}
