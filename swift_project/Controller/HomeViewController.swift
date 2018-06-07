import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
