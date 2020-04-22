//
//  ResortTableViewCell.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class ResortTableViewCell: UITableViewCell {

    @IBOutlet weak var resortNameLabel: UILabel!
    @IBOutlet weak var resortLocationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var resortImage: UIImageView!
    
    var resort: Resort? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let resort = resort else { return }
        resortNameLabel.text = resort.name
        resortLocationLabel.text = resort.location + ", UT"
        resortImage.image = UIImage(named: "\(resort.name) Cell")
        distanceLabel.isHidden = true
        temperatureLabel.isHidden = true
        //temperatureLabel.text = "\(resort.temperature)°"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
