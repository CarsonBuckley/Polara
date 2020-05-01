//
//  TripController.swift
//  Polara
//
//  Created by Carson Buckley on 5/27/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation
import Firebase
import UserNotifications

class TripController: Notification {
    
    //Singleton
    static let sharedInstance = TripController()
    
    //Firebase References
    let db = Firestore.firestore().collection("trips")
    
    //Source of Truth
    var trips: [Trip] = []
    var creatorOfTrip: Person?
    var trip: Trip?
    
    func createTrip(resortName: String, resortLocation: String, resortState: String, date: Double, completion: @escaping (Bool) -> Void) {
        guard let currentUser = PersonController.sharedInstance.currentUser else { completion(false) ; return }
        let documentRef = db.document()
        let newTrip = Trip(userID: currentUser.firebaseUID, id: documentRef.documentID, resortName: resortName, resortLocation: resortLocation, resortState: resortState, date: date, invitedContacts: currentUser.invitedUsersFirebase)
        
        self.trip = newTrip
        scheduleUserNotification(for: newTrip)

        documentRef.setData(newTrip.dictionaryRepresentaion) { (error) in
            if let error = error {
                print("ERROR SYNCING TRIP TO FIRESTORE \(error.localizedDescription) ❌❌❌❌❌")
                completion(false)
                return
            } else {
                print("SUCCESS SYNCING TRIP TO FIRESTORE ✅✅✅✅✅")
                completion(true)
            }
        }
    }
    
    func fetchTrips(firebaseUID: String, completion: @escaping (Bool) -> Void) {
        Firestore.firestore().collection("trips").whereField("invitedContacts", arrayContains: firebaseUID).getDocuments { (snapshots, error) in
            if let error = error {
                print("THERE WAS AN ERROR FETCHING USER: \(error.localizedDescription) ❌❌❌❌❌")
                completion(false)
                return
            }
            self.trips.removeAll()
            for document in snapshots!.documents {
                guard let trip = Trip(dictionary: document.data()) else { print("❌"); return }
                if trip.date >= Date().timeIntervalSince1970 {
                    self.trips.append(trip)
                }
                self.trips.sort(by: { $0.date < $1.date })
                print("\(document == snapshots?.documents.last)")
            }
            completion(true)
        }
    }
    
//    func fetchAllTrips(completion: @escaping (Bool) -> Void) {
//        Firestore.firestore().collection("trips").getDocuments { (snapshots, error) in
//            if let error = error {
//                print("THERE WAS AN ERROR FETCHING USER: \(error.localizedDescription) ❌❌❌❌❌")
//                completion(false)
//                return
//            }
//            self.trips.removeAll()
//            for document in snapshots!.documents {
//                guard let trip = Trip(dictionary: document.data()) else { print("❌"); return }
//                self.trips.append(trip)
//                self.trips.sort(by: { $0.date < $1.date })
//                print("\(document == snapshots?.documents.last)")
//            }
//            completion(true)
//        }
//    }
}



















//    func fetchContacts(contact: Person, firebaseUID: String, completion: @escaping (Bool) -> Void) {
//        Firestore.firestore().collection("users").whereField("contacts", arrayContains: contact.firebaseUID).getDocuments { (snapshots, error) in
//            if let error = error {
//                print("THERE WAS AN ERROR FETCHING USER: \(error.localizedDescription) ❌❌❌❌❌")
//                completion(false)
//                return
//            }
//            self.contacts.removeAll()
//            for document in snapshots!.documents {
//                guard let contact = Person(dictionary: document.data()) else {
//                    print("❌")
//                    return
//
//                }
//                if contact.blockedUsersFirebase.contains(firebaseUID) {
//                    continue
//                } else {
//                    self.contacts.append(contact)
//                    self.contacts.sort(by: { $0.name < $1.name })
//                    print("\(document == snapshots?.documents.last)")
//                }
//            }
//            completion(true)
//        }
//    }

protocol Notification: class {
    func scheduleUserNotification(for trip: Trip)
    func cancelUserNotification(for trip: Trip)
}

extension Notification{
    
    func scheduleUserNotification(for trip: Trip){
        
//        let content = UNMutableNotificationContent()
//        content.title = "Polara Ski Trip"
//        content.body = "\(String(describing: PersonController.sharedInstance.currentUser)) wants to go to \(trip.resortName) with you on \(trip.date)"
//        content.sound = UNNotificationSound.default
//
//        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: trip.date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
//        let request = UNNotificationRequest(identifier: trip.id, content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request) { (error) in
//            if let error = error{
//                print("Error scheduling local user notifications \(error.localizedDescription)  :  \(error)")
//            }
//        }
    }
    
    func cancelUserNotification(for trip: Trip){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [trip.id])
    }
}
