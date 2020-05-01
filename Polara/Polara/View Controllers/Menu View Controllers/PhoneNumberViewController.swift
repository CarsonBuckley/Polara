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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var contacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatKeyboard()
        phoneNumberTextfield.delegate = self
        guard let user = PersonController.sharedInstance.currentUser else { return }
        phoneNumberTextfield.font = UIFont(name: "Roboto-Bold", size: 17)
        phoneNumberTextfield.text = user.phoneNumber
        //saveButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 17)
        saveButton.layer.cornerRadius = 5
        saveButton.backgroundColor = .iceBlue
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func formatKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            //self.bottomConstraint.constant = keyboardFrame.height
            self.view.layoutSubviews()
            //let frameInContentView = self.phoneNumberTextfield.convert(self.phoneNumberTextfield.bounds, to: self.contentView)
            //let offSetPoint = CGPoint(x: self.contentView.frame.origin.x, y: frameInContentView.origin.y - frameInContentView.height)
            //self.scrollView.setContentOffset(offSetPoint, animated: true)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            //self.bottomConstraint.constant = 0
        }
        //scrollView.keyboardDismissMode = .onDrag
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
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
