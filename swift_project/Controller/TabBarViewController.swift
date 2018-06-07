import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var overallTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
        
        // Set the title for each items
        self.overallTabBar.items?[0].title = "Quiz"
        self.overallTabBar.items?[1].title = "Classement"
        self.overallTabBar.items?[2].title = "Profil"
        self.overallTabBar.items?[3].title = "Recherche"
        
        // Set the icons for each items when they are select/unselect
        self.overallTabBar.items?[0].image = UIImage(named: "Quiz")?.withRenderingMode(.alwaysOriginal)
        self.overallTabBar.items?[0].selectedImage = UIImage(named: "QuizActive")?.withRenderingMode(.alwaysOriginal)
        
        self.overallTabBar.items?[1].image = UIImage(named: "Classification")?.withRenderingMode(.alwaysOriginal)
        self.overallTabBar.items?[1].selectedImage = UIImage(named: "ClassificationActive")?.withRenderingMode(.alwaysOriginal)
        
        self.overallTabBar.items?[2].image = UIImage(named: "Profil")?.withRenderingMode(.alwaysOriginal)
        self.overallTabBar.items?[2].selectedImage = UIImage(named: "ProfilActive")?.withRenderingMode(.alwaysOriginal)
        
        self.overallTabBar.items?[3].image = UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal)
        self.overallTabBar.items?[3].selectedImage = UIImage(named: "SearchActive")?.withRenderingMode(.alwaysOriginal)
        
        // Set the color for each items when they are select/unselect
        let selectedColor = UIColor(red: 40/255.0, green: 177/255.0, blue: 109/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 71/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1.0)
        
        self.overallTabBar.items?[0].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        self.overallTabBar.items?[1].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        self.overallTabBar.items?[2].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        self.overallTabBar.items?[3].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        
        self.overallTabBar.items?[0].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        self.overallTabBar.items?[1].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        self.overallTabBar.items?[2].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        self.overallTabBar.items?[3].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
    }
    
    /**
    * Set up the tab bar for the separate storyboard
    * @return Void
    **/
    func setUpTabBar() -> Void {
        let firstStoryboard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let firstViewController:UIViewController = firstStoryboard.instantiateViewController(withIdentifier:"NavBarHomeView")
        
        let secondStoryboard:UIStoryboard = UIStoryboard(name: "Classification", bundle: nil)
        let secondViewController:UIViewController = secondStoryboard.instantiateViewController(withIdentifier :"ClassificationView")
        
        let thirdStoryboard:UIStoryboard = UIStoryboard(name: "Profil", bundle: nil)
        let thirdViewController:UIViewController = thirdStoryboard.instantiateViewController(withIdentifier:"NavBarProfilView")
        
        let fourthStoryboard:UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let fourthViewController:UIViewController = fourthStoryboard.instantiateViewController(withIdentifier:"NavBarSearchView")
        
        self.viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
    }
}
