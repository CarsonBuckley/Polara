//
//  User.swift
//  Polara
//
//  Created by Carson Buckley on 5/11/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation
import Firebase

class PersonController {
    
    static let sharedInstance = PersonController()
    
    //Firebase References
    let accountRef = Firestore.firestore().collection("users")
    
    //Source of Truth
    var currentUser: Person?    
    var contacts: [Person] = []
    
    func createAccount(name: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            if let error = error {
                print("THERE WAS AN ERROR: \(error.localizedDescription) ❌❌❌❌❌")
                completion(false)
                return
            }
            guard let authData = authData else { completion(false); return }
            let userUID = authData.user.uid
            
            let docRef = self.accountRef.document(userUID)
            
            let newPerson = Person(name: name, email: email, phoneNumber: nil, contacts: [], firebaseUID: userUID, docRef: docRef)
            
            self.currentUser = newPerson
            
            self.accountRef.document(userUID).setData(newPerson.dictionary) { error in
                if let error = error {
                    print("ERROR WRITING DOCUMENT: \(error.localizedDescription) ❌❌❌❌❌")
                    completion(false)
                } else {
                    print("SUCCESS WRITING DOCUMENT ✅✅✅✅✅")
                    completion(true)
                }
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if let error = error {
                print("THERE WAS AN ERROR SIGNING IN \(error.localizedDescription) ❌❌❌❌❌")
                completion(nil, error)
                return
            }
            guard let authData = authData else { completion(nil, error); return }
            let fireBaseUID = authData.user.uid
            completion(fireBaseUID, nil)
        }
    }
    
    func initializeUser(fireBaseUID: String, completion: @escaping (Bool) -> Void) {
        accountRef.document(fireBaseUID).getDocument { (docSnapshot, error) in
            if let error = error {
                print("THERE WAS AN ERROR FINDING USER WITH THAT USERID: \(error.localizedDescription) ❌❌❌❌❌")
                completion(false)
                return
            } else {
                guard let docSnapshot = docSnapshot else { completion(false); return }
                if docSnapshot.exists {
                    let user = Person(dictionary: docSnapshot.data()!)
                    self.currentUser = user
                    completion(true)
                    print("SUCCESS FINDING USER WITH USERID ✅✅✅✅✅")
                }
            }
        }
    }
    
    func signOutUser(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            print("SUCCESS LOGGING OUT USER ✅✅✅✅✅")
            completion(true)
        } catch let error {
            print("FAILED TO LOG OUT USER: \(error.localizedDescription) ❌❌❌❌❌")
            completion(false)
        }
    }
    
    func updatePassword(email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("FAILED TO SEND EMAIL TO USER: \(error.localizedDescription) ❌❌❌❌❌")
                completion(false, error)
                return
            } else {
                print("SUCCESS SENDING EMAIL TO USER ✅✅✅✅✅")
                completion(true, nil)
            }
        }
    }
    
    func updatePhoneNumber(docRef: DocumentReference, phoneNumber: String, completion: @escaping (Bool) -> Void) {
        let docData: [String: Any] = [
            "phoneNumber" : phoneNumber,
        ]
        
        docRef.updateData(docData) { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            } else {
                print("UPDATED USER PHONENUMBER ✅✅✅✅✅")
                completion(true)
            }
        }
    }
    
    func deleteUser(user: User, currentUser: Person, completion: @escaping (Bool) -> Void) {
        user.delete { (error) in
            if let error = error {
                print("THERE WAS AN ERROR DELETING THE USER \(error.localizedDescription) ❌❌❌❌❌")
                completion(false)
                return
            } else {
                currentUser.selfDocRef.delete(completion: { (error) in
                    if let error = error {
                        print("THERE WAS AN ERROR DELETING USER: \(error.localizedDescription) ❌❌❌❌❌")
                        completion(false)
                        return
                    } else {
                        print("SUCCESS DELETING USER ✅✅✅✅✅")
                        completion(true)
                    }
                })
            }
        }
    }
    
    func saveUserToFirestore(completion: @escaping (Bool) -> Void) {
        self.currentUser!.selfDocRef.setData(currentUser!.dictionary) { (error) in
            if let error = error {
                print("FAILED TO SAVE USER TO FIRESTORE: \(error.localizedDescription) ❌❌❌❌❌")
            }
            completion(true)
        }
    }
    
    func addContactToUser(person: Person, completion: @escaping (Bool) -> Void) {
        if self.currentUser!.contacts.contains(person.firebaseUID) {
            completion(false)
            return
        }
        self.currentUser?.contacts.append(person.firebaseUID)
        saveUserToFirestore(completion: completion)
    }
    
    func addCurrentUser(to person: Person, completion: @escaping (Bool) -> Void) {
        Firestore.firestore().collection("users").document(person.firebaseUID).updateData(["contacts": FieldValue.arrayUnion([currentUser!.firebaseUID])]) { (error) in
            if let error = error {
                print("THERE WAS AN ERROR: \(error.localizedDescription) ❌❌❌❌❌")
                completion(false)
                return
            } else {
                completion(true)
                print("SUCCESS ✅✅✅✅✅")
            }
        }
    }
    
    func searchForContact(phoneNumber: String, completion: @escaping (Person) -> Void) {
        Firestore.firestore().collection("users").whereField("phoneNumber", isEqualTo: phoneNumber).getDocuments { (snapshots, error) in
            if let error = error {
                print("THERE WAS AN ERROR SEARCHING FOR USER: \(error.localizedDescription) ❌❌❌❌❌")
                return
            }
            for document in snapshots!.documents {
                guard let person = Person(dictionary: document.data()) else {
                    print("❌")
                    return
                }
                completion(person)
            }
        }
    }
    
    func fetchContacts(contact: Person, firebaseUID: String, completion: @escaping (Bool) -> Void) {
        Firestore.firestore().collection("users").whereField("contacts", arrayContains: contact.firebaseUID).getDocuments { (snapshots, error) in
            if let error = error {
                print("THERE WAS AN ERROR FETCHING USER: \(error.localizedDescription) ❌❌❌❌❌")
                completion(false)
                return
            }
            self.contacts.removeAll()
            for document in snapshots!.documents {
                guard let contact = Person(dictionary: document.data()) else { print("❌"); return }
                if contact.blockedUsersFirebase.contains(firebaseUID) {
                    continue
                } else {
                    self.contacts.append(contact)
                    self.contacts.sort(by: { $0.name < $1.name })
                    print("\(document == snapshots?.documents.last)")
                }
            }
            completion(true)
        }
    }
    
    func blockContact(contact: Person, completion: @escaping (Bool) -> Void) {
        if self.currentUser!.blockedUsersFirebase.contains(contact.firebaseUID) {
            completion(false)
            return
        }
        self.currentUser?.blockedUsersFirebase.append(contact.firebaseUID)
        saveUserToFirestore(completion: completion)
    }
    
    func unblockContact(contact: Person, completion: @escaping (Bool) -> Void) {
        if self.currentUser!.blockedUsersFirebase.contains(contact.firebaseUID) {
            self.currentUser?.blockedUsersFirebase.removeAll(where: {$0 == "\(contact.firebaseUID)"})
            saveUserToFirestore(completion: completion)
            completion(true)
            return
        }
    }
    
    func inviteContact(contact: Person, completion: @escaping (Bool) -> Void) {
        if self.currentUser!.invitedUsersFirebase.contains(contact.firebaseUID) {
            completion(false)
            return
        }
        self.currentUser?.invitedUsersFirebase.append(contact.firebaseUID)
        self.currentUser?.invitedUsersFirebase.append(currentUser!.firebaseUID)
        saveUserToFirestore(completion: completion)
    }
    
    func uninviteContact(contact: Person, completion: @escaping (Bool) -> Void) {
        if self.currentUser!.invitedUsersFirebase.contains(contact.firebaseUID) {
            self.currentUser?.invitedUsersFirebase.removeAll(where: {$0 == "\(contact.firebaseUID)"})
            saveUserToFirestore(completion: completion)
            completion(true)
            return
        }
    }
    
    func removeInvitedContacts(completion: @escaping (Bool) -> Void) {
        //if self.currentUser!.invitedUsersFirebase.contains(contact.firebaseUID) {
        self.currentUser?.invitedUsersFirebase.removeAll()
        saveUserToFirestore(completion: completion)
        completion(true)
        return
    }
}
