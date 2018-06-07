import UIKit
import Firebase
import FirebaseStorage

class UserFindViewController: UIViewController {

    var ref: DatabaseReference!
    var allUsers: [User] = []
    var user: User!
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    @IBOutlet weak var bottomUsernameLabel: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilPicture: UIImageView!
    @IBOutlet weak var beginMatch: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        ref.child("users").observe(.value) { (snapshot) in
            for data in snapshot.children {
                self.allUsers.append(User(snapshot: data as AnyObject)!)
            }
            
            let randomUser = arc4random_uniform(UInt32(self.allUsers.count))
            self.user = self.allUsers[Int(randomUser)]
            
            let profilPicture = self.imageReference.child(self.user.picture!)
            profilPicture.getData(maxSize: 15 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    self.profilPicture.image = UIImage(data: data!)
                }
            }
            
            self.ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 0).observeSingleEvent(of: .value, with: { snapshot in
                self.loseLabel.text = String(snapshot.childrenCount) + " défaites"
            })
            
            self.ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 1).observeSingleEvent(of: .value, with: { snapshot in
                self.winLabel.text = String(snapshot.childrenCount) + " victoires"
            })
            
            self.bottomUsernameLabel.text = self.user.username
            self.usernameLabel.text = self.user.username
            self.levelLabel.text = "Niveau " + String(describing: self.user.level!)
            
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
