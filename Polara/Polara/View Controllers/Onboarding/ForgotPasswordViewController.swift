//
//  ForgotPasswordViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatKeyboard()
        emailTextfield.delegate = self
        sendEmailButton.layer.cornerRadius = 3
        sendEmailButton.layer.borderWidth = 1.5
        sendEmailButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        sendEmailButton.setTitle("SEND", for: .normal)
        // Do any additional setup after loading the view.
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEditing == true {
            UIView.animate(withDuration: 0.3) {
                self.activityIndicator.stopAnimating()
                self.sendEmailButton.setTitle("SEND", for: .normal)
                self.sendEmailButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func errorButton() {
        UIView.animate(withDuration: 0.3) {
            self.sendEmailButton.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            self.sendEmailButton.setTitleColor(.white, for: .normal)
            self.sendEmailButton.setTitle("RE-CHECK EMAIL", for: .normal)
            self.activityIndicator.stopAnimating()
        }
    }
    
    func formatKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            self.bottomConstraint.constant = keyboardFrame.height
            self.view.layoutSubviews()
            let frameInContentView = self.emailTextfield.convert(self.emailTextfield.bounds, to: self.contentView)
            let offSetPoint = CGPoint(x: self.contentView.frame.origin.x, y: frameInContentView.origin.y - frameInContentView.height)
            self.scrollView.setContentOffset(offSetPoint, animated: true)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            self.bottomConstraint.constant = 0
        }
        scrollView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        guard let emailText = emailTextfield.text, !emailText.isEmpty else { errorButton(); return }
        PersonController.sharedInstance.updatePassword(email: emailText) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
                UIView.animate(withDuration: 0.3) {
                    self.sendEmailButton.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    self.sendEmailButton.setTitleColor(.white, for: .normal)
                    self.sendEmailButton.setTitle("RE-CHECK EMAIL", for: .normal)
                    self.activityIndicator.stopAnimating()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.sendEmailButton.layer.borderColor = #colorLiteral(red: 0.4, green: 0.8, blue: 1, alpha: 1)
                    self.sendEmailButton.setTitleColor(.iceBlue, for: .normal)
                    self.sendEmailButton.setTitle("EMAIL SENT", for: .normal)
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
