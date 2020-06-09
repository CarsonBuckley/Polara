//
//  ContactTableViewCell.swift
//  Polara
//
//  Created by Carson Buckley on 5/16/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

protocol ContactTableViewCellDelegate: class {
    func buttonTapped(contact: Person, sender: ContactTableViewCell)
}

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneNumberLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    //Landing Pad
    var contact: Person? {
        didSet {
            updateViews()
        }
    }
    
    var status: ContactCellStatus?
    weak var delegate: ContactTableViewCellDelegate?
    
    func updateViews() {
        guard let contact = contact else { return }
        guard let user = PersonController.sharedInstance.currentUser else { return }
        if self.status == .block {
            if user.blockedUsersFirebase.contains(contact.firebaseUID) {
                var title: String
                var borderColor: UIColor
                title = "Blocked"
                borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                cellButton.setTitle(title, for: .normal)
                cellButton.layer.borderColor = borderColor.cgColor
            } else {
                cellButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                var title: String
                if self.status == .block {
                    title = "Block"
                    cellButton.setTitle(title, for: .normal)
                }
            }
        }
        
        if self.status == .invite {
            if user.invitedUsersFirebase.contains(contact.firebaseUID) {
                var title: String
                var borderColor: UIColor
                title = "Invited"
                borderColor = #colorLiteral(red: 0.4, green: 0.8, blue: 1, alpha: 1)
                cellButton.setTitle(title, for: .normal)
                cellButton.layer.borderColor = borderColor.cgColor
            } else {
                cellButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                var title: String
                if self.status == .invite {
                    title = "Invite"
                    self.cellButton.setTitle(title, for: .normal)
                }
            }
        }
        contactNameLabel.text = contact.name
        contactPhoneNumberLabel.text = contact.phoneNumber
        contactPhoneNumberLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        cellButton.layer.cornerRadius = 5
        cellButton.layer.borderWidth = 3
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func cellButtonTapped(_ sender: Any) {
        guard let contact = contact else { return }
        delegate?.buttonTapped(contact: contact, sender: self)
        print("CELL BUTTON TAPPED")
    }
}

enum ContactCellStatus {
    case block
    case invite
}
