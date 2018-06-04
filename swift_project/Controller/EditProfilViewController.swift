import UIKit
import Firebase

class EditProfilViewController: UIViewController {

    @IBOutlet weak var titleNavBar: UINavigationItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var oldPasswordField: UITextField!
    
    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveNewInformations(_ sender: Any) {
        print("sender send")
        if let email = self.mailField.text,
            let newPassword = self.passwordField.text,
            let oldPassword = self.oldPasswordField.text {
            let credential = EmailAuthProvider.credential(withEmail: (self.firebaseAuth?.email)!, password: oldPassword)
        
            self.firebaseAuth?.reauthenticate(with: credential) { error in
                if let error = error {
                    print(error)
                } else {
                    self.firebaseAuth?.updateEmail(to: email) { error in
                        if ((error) != nil) {
                            print(error ?? "error mail")
                        }else {
                            print ("L'email a bien était changé")
                        }
                    }
                    self.firebaseAuth?.updatePassword(to: newPassword) { error in
                        if ((error) != nil) {
                            print(error ?? "error password")
                        }else {
                            print ("Le mot de passe a bien était changé")
                        }
                    }
                }
            }
        }
    }
}

