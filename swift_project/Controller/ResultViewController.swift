import UIKit
import Firebase
import FirebaseStorage

class ResultViewController: UIViewController  {
    
    let firebaseAuth = Auth.auth()
    var ref = Database.database().reference()
    var exp = 0
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }
    var result: Bool = true
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var pictureUser: UIImageView!
    @IBOutlet weak var experiencePoints: UILabel!
    @IBOutlet weak var victoryNumber: UILabel!
    @IBOutlet weak var defeatNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(firebaseAuth.currentUser!.uid)
        ref.child("users/\(self.firebaseAuth.currentUser!.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let user = User(snapshot : value!)
            let profilPicture = self.imageReference.child((user?.picture)!)
            self.exp = (user?.experience)!
            profilPicture.getData(maxSize: 15 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    self.pictureUser.image = UIImage(data: data!)
                    self.pictureUser.maskCircle(anyImage : self.pictureUser.image!)
                }
            }
        })
        
        if result {
            self.resultLabel.text = "Victoire"
            self.exp = self.exp + 15
            self.ref.child("users/\(self.firebaseAuth.currentUser!.uid)").updateChildValues([
                "experience" : 30
            ])
        } else {
            self.resultLabel.text = "Défaite"
        }
        
        ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 0).observeSingleEvent(of: .value, with: { snapshot in
             self.defeatNumber.text = String(snapshot.childrenCount)
        })
        
        ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 1).observeSingleEvent(of: .value, with: { snapshot in
            self.victoryNumber.text = String(snapshot.childrenCount)
        })
    }
    @IBAction func goToHomePage(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let challengeStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let challengeController = challengeStoryboard.instantiateViewController(withIdentifier: "TabBarView")
        self.present(challengeController, animated: true, completion: nil)
    }
    
    @IBAction func goToChallengePage(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let challengeStoryboard = UIStoryboard(name: "History", bundle: nil)
        let challengeController = challengeStoryboard.instantiateViewController(withIdentifier: "NavBarHistoryView")
        self.present(challengeController, animated: true, completion: nil)
    }
}
