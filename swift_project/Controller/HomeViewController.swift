import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    
    // Set Outlet and actions
//    @IBOutlet weak var quizImage: UIImageView!
//    @IBOutlet weak var challengeBlock: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        quizImage.image = UIImage(named: "quiz_image")
//
//        challengeBlock.layer.shadowColor = UIColor.black.cgColor
//        challengeBlock.layer.shadowOpacity = 0.2
//        challengeBlock.layer.cornerRadius = 10
//        challengeBlock.layer.shadowOffset = CGSize.zero
    }
}
