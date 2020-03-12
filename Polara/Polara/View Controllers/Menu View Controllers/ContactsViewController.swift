//
//  ContactsTableViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/20/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import Firebase

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addContactButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let user = PersonController.sharedInstance.currentUser else { return }
        PersonController.sharedInstance.fetchContacts(contact: user, firebaseUID: user.firebaseUID) { (success) in
            if success {
                if PersonController.sharedInstance.contacts.isEmpty {
                    print("FAILED TO FIND CONTACTS ❌❌❌❌❌")
                    return
                } else {
                    print("DISPLAYING ALL CONTACTS ✅✅✅✅✅")
                    self.tableView.reloadData()
                }
            }
        }
        let contactCellNib = UINib(nibName: "ContactCell", bundle: nil)
        tableView.register(contactCellNib, forCellReuseIdentifier: "contactCell")
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = PersonController.sharedInstance.currentUser else { return }
        PersonController.sharedInstance.fetchContacts(contact: user, firebaseUID: user.firebaseUID) { (success) in
            if success {
                if PersonController.sharedInstance.contacts.isEmpty {
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
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.sharedInstance.contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height / 6
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell
        
        // Configure the cell...
        let contact = PersonController.sharedInstance.contacts[indexPath.row]
        cell?.cellButton.setTitle("", for: .normal)
        cell?.status = .block
        cell?.contact = contact
        cell?.delegate = self
        
        return cell ?? UITableViewCell()
    }

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
}

extension ContactsViewController: ContactTableViewCellDelegate {
    
    func buttonTapped(contact: Person, sender: ContactTableViewCell) {
        guard let user = PersonController.sharedInstance.currentUser else { return }
        if user.blockedUsersFirebase.contains(contact.firebaseUID) {
            UIView.animate(withDuration: 0.3) {
                PersonController.sharedInstance.unblockContact(contact: contact, completion: { (success) in
                    if success {
                        sender.updateViews()
                        print("SUCCESS UNBLOCKING CONTACT ✅✅✅✅✅")
                    }
                })
            }
            print(contact.name)
        } else {
            UIView.animate(withDuration: 0.3) {
                PersonController.sharedInstance.blockContact(contact: contact, completion: { (success) in
                    if success {
                        sender.updateViews()
                        print("SUCCESS BLOCKING CONTACT ✅✅✅✅✅")
                    }
                })
            }
            print(contact.name)
        }
    }
}

