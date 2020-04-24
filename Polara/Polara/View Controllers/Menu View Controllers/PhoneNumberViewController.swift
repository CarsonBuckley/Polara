//
//  PhoneNumberViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var contacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextfield.delegate = self
        guard let user = PersonController.sharedInstance.currentUser else { return }
        phoneNumberTextfield.text = user.phoneNumber
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 3
        saveButton.layer.borderColor = #colorLiteral(red: 0.4, green: 0.8, blue: 1, alpha: 1)
        saveButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        guard let user = PersonController.sharedInstance.currentUser, let updatedPhoneNumber = phoneNumberTextfield.text else { return }
        PersonController.sharedInstance.updatePhoneNumber(docRef: user.selfDocRef, phoneNumber: updatedPhoneNumber) { (success) in
            if success {
                print("SUCCESSFULLY SAVED UPDATED PHONENUMBER ✅✅✅✅✅")
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.saveButton.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                self.saveButton.setTitle("RE-CHECK INPUT", for: .normal)
                print("FAILED TO SAVE UPDATED PHONENUMBER ❌❌❌❌❌")
            }
        }
    }
}
