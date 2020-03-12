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
    var fromCreate: Bool = false
    
    //let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fromCreate == true {
            self.tabBarController?.selectedIndex = 2
            fromCreate = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResortController.sharedInstance.resorts.count
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = self.view.frame.height / 3
//        return height
//    }
    
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
}
