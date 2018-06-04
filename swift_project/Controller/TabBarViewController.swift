import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }
    
    /**
    * Set up the tab bar for the separate storyboard
    * @return void
    **/
    func setUpTabBar(){
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
