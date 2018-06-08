import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var ref = Database.database().reference()
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    var allChallenges: [Challenge] = []

    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var imageQuiz: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet var experienceBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let user = User(snapshot : value!)
            
            self.usernameLabel.text = user?.username
            self.levelLabel.text = "Niveau " + String((user?.level)!)
            self.experienceLabel.text = String((user?.experience)!) + "xp/200xp"
        })
    }
}
