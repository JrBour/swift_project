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

        let secondStoryboard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let secondViewController:UIViewController = secondStoryboard.instantiateViewController(withIdentifier :"HomeView")
        
        let thirdStoryboard:UIStoryboard = UIStoryboard(name: "Profil", bundle: nil)
        let thirdViewController:UIViewController = thirdStoryboard.instantiateViewController(withIdentifier:"ProfilView")
        
        let firstStoryboard:UIStoryboard = UIStoryboard(name: "Classification", bundle: nil)
        let firstViewController:UIViewController = firstStoryboard.instantiateViewController(withIdentifier:"ClassificationView")
        
        self.viewControllers = [firstViewController, secondViewController, thirdViewController]
        self.selectedIndex = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
