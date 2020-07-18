//
//  LabelViewController.swift
//  Polara
//
//  Created by Carson Buckley on 4/7/20.
//  Copyright © 2020 Foundry. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController {

    @IBOutlet weak var robotoLabel: UILabel!
    @IBOutlet weak var systemLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        robotoLabel.font = UIFont(name: "Roboto-Bold", size: 30)
        robotoLabel.text = "Powder Mountain"
        robotoLabel.textColor = .white
        
        systemLabel.text = "Powder Mountain"
        systemLabel.textColor = .white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
