//
//  MenuViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/12/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {

    @IBOutlet weak var referralCodeStackView: UIStackView!
    @IBOutlet weak var referralCodeLabel: UILabel!
    @IBOutlet weak var contactsButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsButton.layer.cornerRadius = 5
        contactsButton.backgroundColor = .white
        contactsButton.setTitleColor(.black, for: .normal)
        notificationsButton.layer.cornerRadius = 5
        notificationsButton.backgroundColor = .white
        notificationsButton.setTitleColor(.black, for: .normal)
//        notificationsButton.isHidden = true
        referralCodeStackView.isHidden = true
        
        print(ResortController.sharedInstance.resortNames.count)
        print(ResortController.sharedInstance.resortLocations.count)
        print(ResortController.sharedInstance.resortStates.count)
        print(ResortController.sharedInstance.resortCoordinates.count)
        print(ResortController.sharedInstance.resortWebsites.count)
        print(ResortController.sharedInstance.resortWebsiteNames.count)
        print(ResortController.sharedInstance.resortTopElevation.count)
        print(ResortController.sharedInstance.resortSkiableAcres.count)
        print(ResortController.sharedInstance.resortNumberOfTrails.count)
        print(ResortController.sharedInstance.resortMapURL.count)
        print(ResortController.sharedInstance.resortAddress.count)
        print(ResortController.sharedInstance.resortPhoneNumber.count)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
