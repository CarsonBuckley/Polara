//
//  DateFormatter.swift
//  Polara
//
//  Created by Carson Buckley on 7/29/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation

extension Date {
    func stringWith(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}
