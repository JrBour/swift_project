import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TabBarView")
        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMove(toParentViewController : self)
    }
}
