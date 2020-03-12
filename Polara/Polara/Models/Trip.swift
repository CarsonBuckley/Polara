//
//  Trip.swift
//  Polara
//
//  Created by Carson Buckley on 5/27/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation
import Firebase

class Trip {
    
    //var user: Person?
    var id: String
    var creatorID: String
    var resortName: String
    var resortLocation: String
    var date: Double
    var invitedContacts: [String]
    
    init(userID: String, id: String = UUID().uuidString, resortName: String, resortLocation: String, date: Double, invitedContacts: [String]) {
        self.id = id
        self.creatorID = userID
        self.resortName = resortName
        self.resortLocation = resortLocation
        self.date = date
        self.invitedContacts = invitedContacts
    }
    
    //Convert a Trip to a dictionary format to allow Firebase to read and store the Trip data
    var dictionaryRepresentaion: [String: Any] {
        return [
            "id" : id,
            "creatorID" : creatorID,
            "resortName" : resortName,
            "resortLocation" : resortLocation,
            "date" : date,
            "invitedContacts" : invitedContacts
        ]
    }
}

extension Trip {
    
    convenience init?(dictionary: [String: Any]) {
        guard let creatorID = dictionary["creatorID"] as? String,
            let date = dictionary["date"] as? Double,
            let id = dictionary["id"] as? String,
            let invitedContacts = dictionary["invitedContacts"] as? [String],
            let resortLocation = dictionary["resortLocation"] as? String,
            let resortName = dictionary["resortName"] as? String
            else { return nil }
                
        self.init(userID: creatorID, id: id, resortName: resortName, resortLocation: resortLocation, date: date, invitedContacts: invitedContacts)
    }
}
