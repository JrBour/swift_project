//
//  TabBarViewController.swift
//  swift_project
//
//  Created by Eswolf on 30/05/2018.
//  Copyright © 2018 CDJ. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstStoryboard:UIStoryboard = UIStoryboard(name: "Classification", bundle: nil)
        let firstViewController:UIViewController = firstStoryboard.instantiateViewController(withIdentifier:"ClassificationView")
        
        let secondStoryboard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let secondViewController:UIViewController = secondStoryboard.instantiateViewController(withIdentifier :"HomeView")
        
        let thirdStoryboard:UIStoryboard = UIStoryboard(name: "Profil", bundle: nil)
        let thirdViewController:UIViewController = thirdStoryboard.instantiateViewController(withIdentifier:"navBarProfil")
        
        self.viewControllers = [firstViewController, secondViewController, thirdViewController]
        self.selectedIndex = 1
    }
}
