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

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        TEMPORARILY HIDDEN ITEMS <<<----------------------
//        addEditButton.isHidden = true
        
        firstNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        guard let user = PersonController.sharedInstance.currentUser else { return }
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor(ciColor: .white).cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        firstNameTextField.text = user.name
        emailTextField.text = user.email
        phoneNumberTextField.text = user.phoneNumber
        if user.phoneNumber == "" {
            addEditButton.setTitle("Add", for: .normal)
        } else {
            addEditButton.setTitle("Edit", for: .normal)
        }
        addEditButton.layer.cornerRadius = 5
        addEditButton.backgroundColor = .iceBlue
        addEditButton.setTitleColor(.white, for: .normal)
//        changePasswordButton.layer.cornerRadius = 5
//        changePasswordButton.backgroundColor = .white
//        changePasswordButton.setTitleColor(.black, for: .normal)
//        logOutButton.layer.cornerRadius = 5
//        logOutButton.backgroundColor = .white
//        logOutButton.setTitleColor(.black, for: .normal)
//        deleteAccountButton.layer.cornerRadius = 5
//        deleteAccountButton.backgroundColor = .lavaRed
        deleteAccountButton.setTitleColor(.lavaRed, for: .normal)
        // Remove border on text field
        firstNameTextField.borderStyle = .none
        emailTextField.borderStyle = .none
        phoneNumberTextField.borderStyle = .none
        // Change placeholder text and color
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let id = Auth.auth().currentUser?.uid else { return }
        PersonController.sharedInstance.initializeUser(fireBaseUID: id) { (success) in
            if success {
                guard let user = PersonController.sharedInstance.currentUser else { return }
                self.phoneNumberTextField.text = user.phoneNumber
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
