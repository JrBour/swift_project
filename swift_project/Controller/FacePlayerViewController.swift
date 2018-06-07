import UIKit
import Firebase

class FacePlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
    * Go to the face player page
    * @param        sender      Informations send by the button
    * @return   Void
    */
    @IBAction func segueToSearchUser(_ sender: Any) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "SearchUser", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "NavBarSearchView")
        self.present(homeController, animated: true, completion: nil)
    }
    
    /**
     * Go back to the homepage
     * @param        sender      Informations send by the button
     * @return   Void
     */
    @IBAction func dismissFacePlayer(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "TabBarView")
        self.present(homeController, animated: true, completion: nil)
    }
}
