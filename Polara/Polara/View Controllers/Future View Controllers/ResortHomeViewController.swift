//
//  ResortViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class ResortHomeViewController: UIViewController {
    
    @IBOutlet weak var resortNameLabel: UILabel!
    @IBOutlet weak var resortLocationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var resortImage: UIImageView!
    @IBOutlet weak var passesButton: UIButton!
    @IBOutlet weak var lodgingButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    
    var resort: Resort? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let resort = resort else { return }
        self.navigationItem.title = resort.name.uppercased()
        resortNameLabel.text = resort.name
        resortLocationLabel.text = resort.location + ", UT"
        //temperatureLabel.text = "\(resort.temperature)°"
        resortImage.image = UIImage(named: resort.name)
        resortImage.layer.cornerRadius = resortImage.frame.height / 2
        passesButton.layer.cornerRadius = 3
        passesButton.layer.borderWidth = 1.5
        passesButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lodgingButton.layer.cornerRadius = 3
        lodgingButton.layer.borderWidth = 1.5
        lodgingButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shopButton.layer.cornerRadius = 3
        shopButton.layer.borderWidth = 1.5
        shopButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPassesVC" {
            if let destinationVC = segue.destination as? PassViewController {
                destinationVC.resort = resort
            }
        }
        if segue.identifier == "toLodgingVC" {
            if let destinationVC = segue.destination as? LodgingViewController {
                destinationVC.resort = resort
            }
        }
        if segue.identifier == "toShopVC" {
            if let destinationVC = segue.destination as? ShopViewController {
                destinationVC.resort = resort
            }
        }
    }
}
