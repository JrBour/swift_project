import UIKit
import Firebase

class UserFindViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBackToFacePlayer(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "FacePlayer", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "NavBarFacePlayerView")
        self.present(homeController, animated: true, completion: nil)
    }
    
}
