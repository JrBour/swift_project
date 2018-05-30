import UIKit
import Firebase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        firebaseAuth.addStateDidChangeListener({ (firebaseAuth, user) in
            if user != nil && user != self.currentUser {
                self.currentUser = user
                let homeStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                let homeController = homeStoryboard.instantiateViewController(withIdentifier: "TabBarView")
                self.present(homeController, animated: true, completion: nil)
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

