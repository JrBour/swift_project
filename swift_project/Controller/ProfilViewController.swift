import Firebase
import UIKit

class ProfilViewController: UIViewController {

    let firebaseAuth = Auth.auth()
    var ref: DatabaseReference!
    
    @IBOutlet weak var achievementCollection: UICollectionView!
    
    @IBOutlet weak var editProfil: UIButton!
    @IBOutlet weak var navbarProfil: UISegmentedControl!
    @IBOutlet weak var titleUsernameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        navbarProfil.selectedSegmentIndex = 0
        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            self.usernameLabel.text     = value?["username"] as? String ?? ""
            self.titleUsernameLabel.text = value?["username"] as? String ?? ""
            self.nameLabel.text         = value?["name"] as? String ?? ""
            self.firstnameLabel.text    = value?["firstname"] as? String ?? ""
            self.countryLabel.text      = value?["country"] as? String ?? ""
            let level = value?["level"] as? Int
            self.levelLabel.text = "Niveau " + String(describing: level!)
            
        })
    }
    
    @IBAction func changeInformations(_ sender: Any) {
        let labels: [UIView] = [usernameLabel, nameLabel, countryLabel, firstnameLabel]
        if navbarProfil.selectedSegmentIndex == 0 {
            for  label in labels {
                label.isHidden = false
            }
            achievementCollection.isHidden = true
        } else if navbarProfil.selectedSegmentIndex == 1 {
            for  label in labels {
                label.isHidden = true
            }
            achievementCollection.isHidden = false
        } else if navbarProfil.selectedSegmentIndex == 2 {
            for  label in labels {
                label.isHidden = true
            }
            achievementCollection.isHidden = true
        }
    }
    /**
    * Sign out the current user
    *
    */
    @IBAction func logout(_ sender: Any) {
        do {
            try firebaseAuth.signOut()
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginController = loginStoryboard.instantiateViewController(withIdentifier: "LoginView")
            self.present(loginController, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    /**
    * Set up the corener radius of bouton
    *
    */
    func setUpView() {
        self.editProfil.layer.cornerRadius = 10
        self.editProfil.clipsToBounds = true
    }
}
