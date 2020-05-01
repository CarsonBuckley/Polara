//
//  User.swift
//  Polara
//
//  Created by Carson Buckley on 5/11/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation
import Firebase

class Person {
    var name: String
    var email: String
    var phoneNumber: String?
    var contacts: [String] = []
    let firebaseUID: String
    var selfDocRef: DocumentReference
    var blockedUsersFirebase: [String] = []
    var invitedUsersFirebase: [String] = []
    //var profileImage: UIImage?
    
    init(name: String, email: String, phoneNumber: String?, contacts: [String], firebaseUID: String, docRef: DocumentReference, blockedUsers: [String] = [], invitedUsers: [String] = []) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.contacts = contacts
        self.firebaseUID = firebaseUID
        self.selfDocRef = docRef
        self.blockedUsersFirebase = blockedUsers
        self.invitedUsersFirebase = invitedUsers
    }
    
    var dictionary: [String: Any] {
        return [
            "name" : name,
            "email" : email,
            "phoneNumber" : phoneNumber,
            "contacts" : contacts,
            "firebaseUID" : firebaseUID,
            "selfDocRef" : selfDocRef,
            "blockedUsersFirebase" : blockedUsersFirebase,
            "invitedUsersFirebase" : invitedUsersFirebase
            //"profileImage" : profileImage,
        ]
    }
}

extension Person {
    convenience init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let email = dictionary["email"] as? String,
            let contacts = dictionary["contacts"] as? [String],
            let firebaseUID = dictionary["firebaseUID"] as? String,
            let selfDocRef = dictionary["selfDocRef"] as? DocumentReference,
            let blockedUsersFirebase = dictionary["blockedUsersFirebase"] as? [String],
            let invitedUsersFirebase = dictionary["invitedUsersFirebase"] as? [String]
            else { return nil }
        
        let phoneNumber = dictionary["phoneNumber"] as? String
        
        self.init(name: name, email: email, phoneNumber: phoneNumber, contacts: contacts, firebaseUID: firebaseUID, docRef: selfDocRef, blockedUsers: blockedUsersFirebase, invitedUsers: invitedUsersFirebase)
    }
}
