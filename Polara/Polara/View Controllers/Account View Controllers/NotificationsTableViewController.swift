//
//  NotificationsTableViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class NotificationsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let contactCellNib = UINib(nibName: "ContactCell", bundle: nil)
        tableView.register(contactCellNib, forCellReuseIdentifier: "contactCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PersonController.sharedInstance.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height / 6
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell
        
        // Configure the cell...
        let contact = PersonController.sharedInstance.contacts[indexPath.row]
        cell?.cellButton.isHidden = true
        cell?.contactPhoneNumberLabel.text = "Notification"
        cell?.contact = contact
        
        return cell ?? UITableViewCell()
    }
}
