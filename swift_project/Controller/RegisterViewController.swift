import UIKit
import Firebase

class RegisterViewController: UIViewController {

    var ref: DatabaseReference!
    let firebaseAuth = Auth.auth()
    var lastUserId: Int = 0
    
    @IBOutlet weak var nameFIeld: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("users").observe(DataEventType.value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                self.lastUserId = Int(child.key)! + 1
            }
        })
    }
    
    /**
    * Register a new user
    *
    */
    @IBAction func register(_ sender: Any) {
        if let email = self.emailField.text,
            let password = self.passwordField.text,
            let name = self.nameFIeld.text,
            let firstname = self.firstnameField.text {
            self.ref.child("users").child(String(self.lastUserId)).setValue([
                "name" : name,
                "firstname" : firstname,
                "email" : email
            ])
            firebaseAuth.createUser(withEmail: email, password: password) { user, error in
                if error != nil {
                    print(error!)
                }
            }
        }
    }
    
    
}
