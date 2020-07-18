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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove border on text field
        nameTextField.borderStyle = .none
        emailTextField.borderStyle = .none
        phoneNumberTextField.borderStyle = .none
        
        // Change placeholder text color
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
        
//        TEMPORARILY HIDDEN ITEMS <<<-------------------------------------------------
        nameLabel.isHidden = true
        emailLabel.isHidden = true
        phoneNumberLabel.isHidden = true
        addEditButton.isHidden = true
        
        
        
        
        guard let user = PersonController.sharedInstance.currentUser else { return }
        nameLabel.text = user.name
        emailLabel.text = user.email
        //emailLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        phoneNumberLabel.text = user.phoneNumber
        //phoneNumberLabel
        //phoneNumberLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        if user.phoneNumber == "" {
            addEditButton.setTitle("Add", for: .normal)
        } else {
            addEditButton.setTitle("Edit", for: .normal)
        }
        //addUpdateButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 17)
        addEditButton.layer.cornerRadius = 5
        addEditButton.backgroundColor = .iceBlue
        addEditButton.setTitleColor(.white, for: .normal)
        //changePasswordButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 17)
        changePasswordButton.layer.cornerRadius = 5
        changePasswordButton.backgroundColor = .white
        changePasswordButton.setTitleColor(.black, for: .normal)
        //logOutButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 17)
        logOutButton.layer.cornerRadius = 5
        logOutButton.backgroundColor = .white
        logOutButton.setTitleColor(.black, for: .normal)
        //deleteAccountButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 17)
        deleteAccountButton.layer.cornerRadius = 5
        deleteAccountButton.backgroundColor = .lavaRed
        deleteAccountButton.setTitleColor(.white, for: .normal)
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
                    self.addEditButton.setTitle("Add", for: .normal)
                } else {
                    self.addEditButton.setTitle("Edit", for: .normal)
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
                    self.changePasswordButton.setTitleColor(.iceBlue, for: .normal)
                    self.changePasswordButton.setTitle("Email Sent", for: .normal)
                    print("SUCCESS SENDING PASSWORD RESET ✅✅✅✅✅")
                    self.activityIndicator.stopAnimating()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.changePasswordButton.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    self.changePasswordButton.setTitleColor(.white, for: .normal)
                    self.changePasswordButton.setTitle("Failed", for: .normal)
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
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginScreen")
                // Line below is important after iOS 13 update. It allows the current View Controller [SettingsScreenViewController] to segue to desination VC [LoginViewController] without making the destinationVC present Modally
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true)
            }
        })
    }
}
