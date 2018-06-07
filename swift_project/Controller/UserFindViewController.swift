import UIKit
import Firebase

class UserFindViewController: UIViewController {

    var ref: DatabaseReference!
    var allUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        ref.child("users").observe(.value) { (snapshot) in
            for data in snapshot.children {
                self.allUsers.append(User(snapshot: data as AnyObject)!)
            }
            print(self.allUsers[0].name)
        }
    }
    
    
    @IBAction func beginQuiz(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "Quiz", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "QuizView")
        self.present(homeController, animated: true, completion: nil)
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
