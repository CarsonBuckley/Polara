//
//  CreateTripViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class CreateTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createTripButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    let notBlockedUsers = PersonController.sharedInstance.contacts
    
    var trip: Trip? {
        didSet {
            loadViewIfNeeded()
        }
    }
    
    var resort: Resort? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = resort!.name//.uppercased()
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
        createTripButton.layer.cornerRadius = 5
        createTripButton.setTitleColor(.black, for: .normal)
        createTripButton.backgroundColor = .white
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.datePickerMode = .date
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
        cell?.status = .invite
        cell?.contact = contact
        cell?.delegate = self
        
        return cell ?? UITableViewCell()
    }
    
    @IBAction func createTripButtonTapped(_ sender: Any) {
        print("CREATE TRIP BUTTON TAPPED ✅✅✅✅✅")
        let dateAsDouble = self.datePicker.date.timeIntervalSince1970
        TripController.sharedInstance.createTrip(resortName: resort?.name ?? "", resortLocation: resort?.location ?? "", resortState: resort?.state ?? "", date: dateAsDouble) { (success) in
            if success {
                PersonController.sharedInstance.removeInvitedContacts(completion: { (success) in
                    if success {
                        print("SUCCESS CLEARING INVITED USERS ARRAY ✅✅✅✅✅")
                    } else {
                        print("FAILED TO CLEAR INVITED USERS ARRAY ❌❌❌❌❌")
                    }
                })
                DispatchQueue.main.async {
                    let mainVC = self.navigationController?.viewControllers.first as? ResortsTableViewController
                    mainVC?.fromCreateVC = true
                    self.navigationController?.popToRootViewController(animated: true)
                }
                print("SUCCESS CREATING TRIP ✅✅✅✅✅")
            } else {
                print("FAILED TO CREATE TRIP ❌❌❌❌❌")
            }
        }
    }
}

extension CreateTripViewController: ContactTableViewCellDelegate {
    
    func buttonTapped(contact: Person, sender: ContactTableViewCell) {
        guard let user = PersonController.sharedInstance.currentUser else { return }
        if user.invitedUsersFirebase.contains(contact.firebaseUID) {
            UIView.animate(withDuration: 0.3) {
                PersonController.sharedInstance.uninviteContact(contact: contact, completion: { (success) in
                    if success {
                        sender.updateViews()
                        print("SUCCESS UNINVITING CONTACT ✅✅✅✅✅")
                    }
                })
            }
            print(contact.name)
        } else {
            UIView.animate(withDuration: 0.3) {
                PersonController.sharedInstance.inviteContact(contact: contact, completion: { (success) in
                    if success {
                        sender.updateViews()
                        print("SUCCESS INVITING CONTACT ✅✅✅✅✅")
                    }
                })
            }
            print(contact.name)
        }
    }
}
