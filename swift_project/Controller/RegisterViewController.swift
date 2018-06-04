import UIKit
import Firebase

class RegisterViewController: UIViewController {

    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    
    @IBOutlet weak var nameFIeld: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pseudoField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        firebaseAuth.addStateDidChangeListener({ (firebaseAuth, user) in
            if user != nil && user != self.currentUser {
                self.currentUser = user
            }
        })
    }
    
    /**
    * Register a new user
    *
    */
    @IBAction func register(_ sender: Any) {
        if let email = self.emailField.text,
            let name = self.nameFIeld.text,
            let firstname = self.firstnameField.text,
            let pseudo = self.pseudoField.text,
            let country = self.countryField.text,
            let password = self.passwordField.text {
                firebaseAuth.createUser(withEmail: email, password: password) { user, error in
                if error != nil {
                    print(error!)
                }else {
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue([
                        "firstname" : firstname,
                        "name" : name,
                        "username" : pseudo,
                        "email" : email,
                        "country" : country,
                        "level" : 0,
                        "experience" : 0
                    ])
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "LoginView") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
}
