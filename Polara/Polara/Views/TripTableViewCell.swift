//
//  TripTableViewCell.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var resortNameLabel: UILabel!
    @IBOutlet weak var resortLocationLabel: UILabel!
    @IBOutlet weak var dateOfTripLabel: UILabel!
    
    //Landing Pad
    var trip: Trip? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let trip = trip else { return }        
        resortNameLabel.text = trip.resortName
        resortLocationLabel.text = trip.resortLocation + ", UT ● "
        resortLocationLabel.textColor = .white
        dateOfTripLabel.text = Date(timeIntervalSince1970: trip.date).stringWith(dateStyle: .medium, timeStyle: .none)
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
