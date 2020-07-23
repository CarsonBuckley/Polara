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
    
    //Landing Pad
    var resort: Resort? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let resort = resort else { return }
        resortNameLabel.text = resort.name
        resortLocationLabel.text = "\(resort.location), \(resort.state)"
        resortImage.image = UIImage(named: "\(resort.name) Cell")
        temperatureLabel.textColor = .systemBlue
        distanceLabel.isHidden = true
        
        ResortController.sharedInstance.fetchTemperature(with: resort.coordinates, units: ResortController.sharedInstance.units, language: ResortController.sharedInstance.language, format: ResortController.sharedInstance.format, apiKey: ResortController.sharedInstance.apiKey) { (temperature) in
            guard let temperature = temperature else { print("Failed to fetch resort temperature ❌") ; return }
            self.setTemperatureLabel(temperature)
        }
    }
    
    func setTemperatureLabel(_ temperature: Temperature) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(temperature.temperature)°"
        }
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
