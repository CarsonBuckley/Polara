//
//  SettingsViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/12/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = PersonController.sharedInstance.currentUser else { return }
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneNumberLabel.text = user.phoneNumber
        if user.phoneNumber == "" {
            addUpdateButton.setTitle("ADD", for: .normal)
        } else {
            addUpdateButton.setTitle("UPDATE", for: .normal)
        }
        addUpdateButton.layer.cornerRadius = 3
        addUpdateButton.layer.borderWidth = 1.5
        addUpdateButton.layer.borderColor = #colorLiteral(red: 0.4, green: 0.8, blue: 1, alpha: 1)
        changePasswordButton.layer.cornerRadius = 3
        changePasswordButton.layer.borderWidth = 1.5
        changePasswordButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        logOutButton.layer.cornerRadius = 3
        logOutButton.layer.borderWidth = 1.5
        logOutButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        deleteAccountButton.layer.cornerRadius = 3
        deleteAccountButton.layer.borderWidth = 1.5
        deleteAccountButton.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let id = Auth.auth().currentUser?.uid else { return }
        PersonController.sharedInstance.initializeUser(fireBaseUID: id) { (success) in
            if success {
                guard let user = PersonController.sharedInstance.currentUser else { return }
                self.phoneNumberLabel.text = user.phoneNumber
                if user.phoneNumber == "" {
                    self.addUpdateButton.setTitle("ADD", for: .normal)
                } else {
                    self.addUpdateButton.setTitle("UPDATE", for: .normal)
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func changePasswordButtonTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        guard let user = PersonController.sharedInstance.currentUser else { return }
        PersonController.sharedInstance.updatePassword(email: user.email, completion: { (success, error) in
            if success {
                UIView.animate(withDuration: 0.3) {
                    self.changePasswordButton.layer.borderColor = #colorLiteral(red: 0.4, green: 0.8, blue: 1, alpha: 1)
                    self.changePasswordButton.setTitleColor(.white, for: .normal)
                    self.changePasswordButton.setTitle("EMAIL SENT", for: .normal)
                    print("SUCCESS SENDING PASSWORD RESET ✅✅✅✅✅")
                    self.activityIndicator.stopAnimating()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.changePasswordButton.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    self.changePasswordButton.setTitleColor(.white, for: .normal)
                    self.changePasswordButton.setTitle("FAILED", for: .normal)
                    print("FAILED TO SEND PASSWORD RESET ❌❌❌❌❌")
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        PersonController.sharedInstance.signOutUser(completion: { (success) in
            if success {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginScreen = storyBoard.instantiateViewController(withIdentifier: "loginScreen")
                self.present(loginScreen, animated: true)
            }
        })
    }
}
