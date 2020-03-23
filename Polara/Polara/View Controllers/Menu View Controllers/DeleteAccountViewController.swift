//
//  DeleteAccountViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class DeleteAccountViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var deleteAccountButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteAccountButton.layer.cornerRadius = 3
        deleteAccountButton.layer.borderWidth = 1.5
        deleteAccountButton.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        guard let user = Auth.auth().currentUser,
            let person = PersonController.sharedInstance.currentUser else { return }
        PersonController.sharedInstance.deleteUser(user: user, currentUser: person) { (success) in
            if success {
                print("SUCCESS DELETING USER ✅✅✅✅✅")
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginScreen")
                // Line below is important after iOS 13 update. It allows the current View Controller [DeleteAccountViewController] to segue to desination VC [LoginViewController] without making the destinationVC present Modally
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true)
            } else {
                print("FAILED TO DELETE USER ❌❌❌❌❌")
                UIView.animate(withDuration: 0.3) {
                self.infoLabel.text = "Re-log to confirm deletion of your account"
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
