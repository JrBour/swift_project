import UIKit

class NavigationBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 31/255, green: 185/255, blue: 120/255, alpha: 1)
        let attrs = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attrs
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
