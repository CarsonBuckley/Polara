//
//  LoginViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        // TO PREVENT CURRENT VC [LoginScreenViewController] FROM PRESENTING MODALLY, SIMPLY GO TO STORYBOARD, CLICK ON DESIRED VC, GO TO ATTRIBUTE INSPECTOR, AND LOCATE PRESENTATION -> SELECT FULLSCREEN
        super.viewDidLoad()
        formatKeyboard()
        emailTextfield.delegate = self
        emailTextfield.font = UIFont(name: "Roboto-Bold", size: 17)
        passwordTextfield.delegate = self
        passwordTextfield.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 5
        loginButton.backgroundColor = .white
        loginButton.setTitleColor(.black, for: .normal)
        signUpButton.layer.cornerRadius = 5
        signUpButton.backgroundColor = .white
        signUpButton.setTitleColor(.black, for: .normal)
        isModalInPresentation = true
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        }
        return true
    }

    func errorAlertController(error: String) {
        let alertController = UIAlertController(title: "Problem signing in", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
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
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        guard let email = emailTextfield.text, let password = passwordTextfield.text else { return }
        PersonController.sharedInstance.loginUser(email: email, password: password) { (firebaseUID, error) in
            if let error = error {
                print(error.localizedDescription)
                self.errorAlertController(error: error.localizedDescription)
                self.activityIndicator.stopAnimating()
            }
            guard let firebaseUID = firebaseUID else { return }
            PersonController.sharedInstance.initializeUser(fireBaseUID: firebaseUID, completion: { (success) in
                if success {
                    print("SUCCESS LOGGING IN USER ✅✅✅✅✅")
                    let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTabBar")
                    
                    // Line below is important after iOS 13 update. It allows the current View Controller [LoginViewController] to segue to desination VC [MenuViewController] without making the destinationVC present Modally
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC, animated: true)
                    self.activityIndicator.stopAnimating()
                    return
                }
            })
        }
    }
}
