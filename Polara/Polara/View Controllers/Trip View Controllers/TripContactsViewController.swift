//
//  TripContactsViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class TripContactsViewController: UIViewController {

    @IBOutlet weak var dateOfTripLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        let resortCellNib = UINib(nibName: "TripCell", bundle: nil)
        tableView.register(resortCellNib, forCellReuseIdentifier: "tripCell")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return PersonController.sharedInstance.contacts.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = self.view.frame.height / 8
//        return height
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as? ContactTableViewCell
//        
//        // Configure the cell...
//        let contact = PersonController.sharedInstance.contacts[indexPath.row]
//        
//        cell?.contact = contact
//        
//        return cell ?? UITableViewCell()
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
