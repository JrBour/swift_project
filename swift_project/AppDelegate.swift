//
//  AppDelegate.swift
//  swift_project
//
//  Created by Eswolf on 29/05/2018.
//  Copyright © 2018 CDJ. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ref: DatabaseReference!
    
    override init() {
        super.init()
        FirebaseApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ref = Database.database().reference()
        return true
    }

}

