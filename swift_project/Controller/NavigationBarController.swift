//
//  NavigationBarController.swift
//  swift_project
//
//  Created by Eswolf on 04/06/2018.
//  Copyright © 2018 CDJ. All rights reserved.
//

import UIKit

class NavigationBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 26/255, green: 169/255, blue: 95/255, alpha: 1)
        let attrs = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
}
