//
//  StyleGuide.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit

extension UIView {

    func addTextFieldLine(width: CGFloat = 1, color: UIColor = .lightGray) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
//    func addCornerRadius(_ radius: CGFloat = 5) {
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = radius
//    }
//
//    func addBorderWidth(width: CGFloat = 2) {
//        self.layer.borderWidth = width
//    }
//
//    func addBorderColor(color: UIColor) {
//        self.layer.borderColor = color.cgColor
//    }
//}
}

extension UIColor {
    static let iceBlue = UIColor(named: "iceBlue")!
    static let lavaRed = UIColor(named: "lavaRed")!
    static let darkMode = UIColor(named: "darkMode")!
    static let profilePictureBackground = UIColor(named: "profilePictureBackground")!
}
