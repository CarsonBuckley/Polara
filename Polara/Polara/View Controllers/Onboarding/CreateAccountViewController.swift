//
//  CreateAccountViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatKeyboard()
        nameTextfield.delegate = self
        nameTextfield.font = UIFont(name: "Roboto-Bold", size: 17)
        emailTextfield.delegate = self
        emailTextfield.font = UIFont(name: "Roboto-Bold", size: 17)
        passwordTextfield.delegate = self
        passwordTextfield.font = UIFont(name: "Roboto-Bold", size: 17)
        passwordTextfield.isSecureTextEntry = true
        confirmPasswordTextfield.delegate = self
        confirmPasswordTextfield.font = UIFont(name: "Roboto-Bold", size: 17)
        confirmPasswordTextfield.isSecureTextEntry = true
        createAccountButton.layer.cornerRadius = 5
        createAccountButton.backgroundColor = .white
        createAccountButton.setTitleColor(.black, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEditing == true {
            UIView.animate(withDuration: 0.3) {
                self.activityIndicator.stopAnimating()
                self.createAccountButton.setTitle("CREATE ACCOUNT", for: .normal)
                self.createAccountButton.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextfield {
            emailTextfield.becomeFirstResponder()
        }
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        }
        if textField == passwordTextfield {
            confirmPasswordTextfield.becomeFirstResponder()
        }
        return true
    }
    
    func alertController() {
        let alertController = UIAlertController(title: "Missing Information", message: "It looks like you are missing information needed to create an account, check and make sure everything is filled out and that your passwords match.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true)
    }
    
    func errorButton() {
        UIView.animate(withDuration: 0.3) {
            self.createAccountButton.setTitleColor(.lavaRed, for: .normal)
            self.createAccountButton.setTitle("RE-CHECK INPUTS", for: .normal)
            self.activityIndicator.stopAnimating()
        }
    }
    
    func formatKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            self.bottomConstraint.constant = keyboardFrame.height
            self.view.layoutSubviews()
            let frameInContentView = self.nameTextfield.convert(self.nameTextfield.bounds, to: self.contentView)
            let offSetPoint = CGPoint(x: self.contentView.frame.origin.x, y: frameInContentView.origin.y - frameInContentView.height)
            self.scrollView.setContentOffset(offSetPoint, animated: true)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            self.bottomConstraint.constant = 0
        }
        scrollView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        guard let name = nameTextfield.text, !name.isEmpty, let email = emailTextfield.text, !email.isEmpty, passwordTextfield.text == confirmPasswordTextfield.text, let password = confirmPasswordTextfield.text else { errorButton(); return }
        
        PersonController.sharedInstance.createAccount(name: name, email: email, password: password) { (success) in
            if success {
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTabBar")
                
                // Line below is important after iOS 13 update. It allows the current View Controller [CreateAccountViewController] to segue to desination VC [MenuViewController] without making the destinationVC present Modally
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC, animated: true)
                self.activityIndicator.stopAnimating()
            }
            self.textFieldDidBeginEditing(self.nameTextfield)
            self.textFieldDidBeginEditing(self.emailTextfield)
            self.textFieldDidBeginEditing(self.passwordTextfield)
            self.textFieldDidBeginEditing(self.confirmPasswordTextfield)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
