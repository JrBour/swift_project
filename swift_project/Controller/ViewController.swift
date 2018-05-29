//
//  ViewController.swift
//  swift_project
//
//  Created by Eswolf on 29/05/2018.
//  Copyright © 2018 CDJ. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    /**
    * Log the user to Firebase Auth
    *
    *
    */
    @IBAction func login(_ sender: Any) {
        if let email = self.emailField.text,
            let password = self.passwordField.text {
            firebaseAuth.signIn(withEmail: email, password: password)
        }
    }
}

