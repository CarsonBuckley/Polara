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
        contactsButton.layer.borderWidth = 3
        contactsButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        notificationsButton.layer.cornerRadius = 3
        notificationsButton.layer.borderWidth = 1.5
        notificationsButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        notificationsButton.isHidden = true
        referralCodeStackView.isHidden = true
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
