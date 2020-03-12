//
//  SplashScreenViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/14/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import Firebase

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        findUser()
        isModalInPresentation = true
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func findUser() {
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser?.uid
            PersonController.sharedInstance.initializeUser(fireBaseUID: uid!, completion: { (success) in
                if success {
                    print("SUCCESS LOGGING IN USER ✅✅✅✅✅")
                    let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTabBar")
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC, animated: true)
                    return
                }
            })
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toLoginVC", sender: nil)
            }
        }
    }
}
