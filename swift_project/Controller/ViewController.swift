import UIKit
import Firebase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        firebaseAuth.addStateDidChangeListener({ (firebaseAuth, user) in
            if user != nil && user != self.currentUser {
                self.currentUser = user
                let homeController = self.homeStoryboard.instantiateViewController(withIdentifier: "HomeView")
                self.present(homeController, animated: true) {
                    self.emailField.text = ""
                    self.passwordField.text = ""
                }
            }
        })
    }

    /**
    * Log the user to Firebase Auth
    *
    *
    */
    @IBAction func login(_ sender: Any) {
        if let email = self.emailField.text,
            let password = self.passwordField.text {
            firebaseAuth.signIn(withEmail: email, password: password)
        }
    }
}

