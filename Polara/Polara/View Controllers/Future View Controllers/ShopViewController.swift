//
//  ShopViewController.swift
//  Polara
//
//  Created by Carson Buckley on 5/12/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var resortNameLabel: UILabel!
    @IBOutlet weak var resortLocationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var resortImage: UIImageView!
    @IBOutlet weak var apparelButton: UIButton!
    @IBOutlet weak var giftCardButton: UIButton!
    
    var resort: Resort? {
        didSet {
            loadViewIfNeeded()
            viewDidLoad()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let resort = resort else { return }
        resortNameLabel.text = resort.name
        resortLocationLabel.text = resort.location + ", UT"
        //temperatureLabel.text = "\(resort.temperature)°"
        resortImage.image = UIImage(named: resort.name)
        resortImage.layer.cornerRadius = resortImage.frame.height / 2
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
