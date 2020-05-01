//
//  UpcomingTripsViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import Firebase

class UpcomingTripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let user = PersonController.sharedInstance.currentUser else { return }
        TripController.sharedInstance.fetchTrips(firebaseUID: user.firebaseUID) { (success) in
            if success {
                if TripController.sharedInstance.trips.isEmpty {
                    print("FAILED TO FIND TRIPS ❌❌❌❌❌")
                    return
                } else {
                    print("DISPLAYING ALL TRIPS ✅✅✅✅✅")
                    self.tableView.reloadData()
                }
            }
        }
        let tripCellNib = UINib(nibName: "TripCell", bundle: nil)
        tableView.register(tripCellNib, forCellReuseIdentifier: "tripCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = PersonController.sharedInstance.currentUser else { return }
        TripController.sharedInstance.fetchTrips(firebaseUID: user.firebaseUID) { (success) in
            if success {
                if TripController.sharedInstance.trips.isEmpty {
                    return
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TripController.sharedInstance.trips.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height / 5
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as? TripTableViewCell
        
        // Configure the cell...
        let trip = TripController.sharedInstance.trips[indexPath.row]
//        let resort = ResortController.sharedInstance.resorts[indexPath.row]
        cell?.trip = trip
//        cell?.resort = resort
        
        return cell ?? UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            TripController.sharedInstance.trips.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
