import UIKit
import Firebase

class SearchUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTimeout(2.00, block: { () -> Void in
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)
            
            let homeStoryboard = UIStoryboard(name: "UserFind", bundle: nil)
            let homeController = homeStoryboard.instantiateViewController(withIdentifier: "NavBarUserFindView")
            self.present(homeController, animated: true, completion: nil)
        })
    }
    
    /**
     * Set timeout a chunk of script
     * @param delay      Define the delay before the begining of the function
     * @param block      Closure
     * @return  Return a Timer object
     */
    func setTimeout(_ delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
    /**
     * Go to the face player page
     * @param        sender      Informations send by the button
     * @return   Void
     */
    @IBAction func goBackToFacePlayer(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "FacePlayer", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "NavBarFacePlayerView")
        self.present(homeController, animated: true, completion: nil)
    }
}
