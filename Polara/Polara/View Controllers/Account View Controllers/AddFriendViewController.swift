//
//  AddContactViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    var contacts: [String] = []
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatKeyboard()
        phoneNumberTextfield.delegate = self
        phoneNumberTextfield.font = UIFont(name: "Roboto-Bold", size: 17)
        saveButton.layer.cornerRadius = 5
        saveButton.backgroundColor = .iceBlue
        saveButton.setTitleColor(.white, for: .normal)
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func errorButton() {
        UIView.animate(withDuration: 0.3) {
            self.saveButton.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            self.saveButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.infoLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            self.infoLabel.text = "Nobody in the Polara Database is associated with that phone number"
            self.activityIndicator.stopAnimating()
        }
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
        guard let addedPhoneNumber = phoneNumberTextfield.text, !addedPhoneNumber.isEmpty else { return }
        PersonController.sharedInstance.searchForContact(phoneNumber: addedPhoneNumber) { (person) in
            self.activityIndicator.startAnimating()
            PersonController.sharedInstance.addContactToUser(person: person, completion: { (success) in
                PersonController.sharedInstance.addCurrentUser(to: person, completion: { (success) in
                    if success {
                        print("SUCCESS SEARCHING AND SAVING USER ✅✅✅✅✅")
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("FAILED TO SAVE USER ❌❌❌❌❌")
                        self.errorButton()
                    }
                })
            })
        }
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
