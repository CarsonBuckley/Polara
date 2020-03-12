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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var contacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatKeyboard()
        phoneNumberTextfield.delegate = self
        guard let user = PersonController.sharedInstance.currentUser else { return }
        phoneNumberTextfield.text = user.phoneNumber
        saveButton.layer.cornerRadius = 3
        saveButton.layer.borderWidth = 1.5
        saveButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
            self.bottomConstraint.constant = keyboardFrame.height
            self.view.layoutSubviews()
            let frameInContentView = self.phoneNumberTextfield.convert(self.phoneNumberTextfield.bounds, to: self.contentView)
            let offSetPoint = CGPoint(x: self.contentView.frame.origin.x, y: frameInContentView.origin.y - frameInContentView.height)
            self.scrollView.setContentOffset(offSetPoint, animated: true)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            self.bottomConstraint.constant = 0
        }
        scrollView.keyboardDismissMode = .onDrag
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
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
