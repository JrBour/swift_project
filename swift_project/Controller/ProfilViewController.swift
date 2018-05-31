import Firebase
import UIKit

class ProfilViewController: UIViewController {

    let firebaseAuth = Auth.auth()
    var ref: DatabaseReference!
    
    @IBOutlet weak var editProfil: UIButton!
    @IBOutlet weak var navbarProfil: UISegmentedControl!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var informations: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.usernameLabel.text = value?["username"] as? String ?? ""
            let level = value?["level"] as? Int
            self.levelLabel.text = "Niveau " + String(describing: level!)
        })
    }
    
    @IBAction func changeInformations(_ sender: Any) {
        if navbarProfil.selectedSegmentIndex == 0 {
            informations.text = "Général"
        } else if navbarProfil.selectedSegmentIndex == 1 {
            informations.text = "Trophée"
        } else if navbarProfil.selectedSegmentIndex == 2 {
            informations.text = "Stats"
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
