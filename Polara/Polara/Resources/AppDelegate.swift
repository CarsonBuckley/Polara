//
//  AppDelegate.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let attrs = [
//            NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: UIFont(name: "Roboto", size: 17)!
//        ]
//
//        UINavigationBar.appearance().titleTextAttributes = attrs
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Roboto-Black", size: 17)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        FirebaseApp.configure()
        
        //let db = Firestore.firestore()
        
        // Add a new document with a generated ID <-------------------
//        var ref: DocumentReference? = nil
//        ref = db.collection("users").addDocument(data: [
//            "first": "Carson",
//            "last": "Buckley",
//            "born": 1994
//        ]) { error in
//            if let error = error {
//                print("ERROR ADDING DOCUMENT \(error.localizedDescription) ❌❌❌❌❌")
//            } else {
//                print("DOCUMENT ADDED WITH ID \(ref!.documentID) ✅✅✅✅✅")
//            }
//        }
        
        // Add a second document with a generated ID. <-------------------
//        ref = db.collection("users").addDocument(data: [
//            "first": "Dallin",
//            "middle": "Duke",
//            "last": "Buckley",
//            "born": 1996
//        ]) { error in
//            if let error = error {
//                print("ERROR ADDING DOCUMENT \(error.localizedDescription) ❌❌❌❌❌")
//            } else {
//                print("DOCUMENT ADDED WITH ID \(ref!.documentID) ✅✅✅✅✅")
//            }
//        }
        
        //Gets all data (retrieves the entire collection in Firebase) and prints it in the console <-------------------
//        db.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

