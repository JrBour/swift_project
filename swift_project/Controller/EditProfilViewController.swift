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
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        print("CC")
        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.usernameField.text = value?["username"] as? String ?? ""
            self.nameField.text = value?["name"] as? String ?? ""
            self.mailField.text = value?["email"] as? String ?? ""
            self.firstNameField.text = value?["firstname"] as? String ?? ""
            self.countryField.text = value?["country"] as? String ?? ""
            
        })
    }
    
    
    @IBAction func saveNewInformations(_ sender: Any) {
        print("sender send")
        if let email = self.mailField.text,
            let username = self.usernameField.text,
            let firstname = self.firstNameField.text,
            let name = self.nameField.text,
            let country = self.countryField.text,
            let newPassword = self.passwordField.text,
            let oldPassword = self.oldPasswordField.text {
            let credential = EmailAuthProvider.credential(withEmail: firebaseAuth.currentUser!.email!, password: oldPassword)
        
            self.firebaseAuth.currentUser!.reauthenticate(with: credential) { error in
                if let error = error {
                    print(error)
                } else {
                    self.ref.child("users/\(self.firebaseAuth.currentUser!.uid)").updateChildValues([
                        "username" : username,
                        "name" : name,
                        "email" : email,
                        "firstname" : firstname,
                        "country" : country,
                    ])
                    if email != self.firebaseAuth.currentUser!.email {
                        self.firebaseAuth.currentUser!.updateEmail(to: email) { error in
                            if ((error) != nil) {
                                print(error ?? "error mail")
                            }else {
                                print ("L'email a bien était changé")
                            }
                        }
                    }
                    self.firebaseAuth.currentUser!.updatePassword(to: newPassword) { error in
                        if ((error) != nil) {
                            print(error ?? "error password")
                        }else {
                            let profilStoryboard = UIStoryboard(name: "Profil", bundle: nil)
                            let profilController = profilStoryboard.instantiateViewController(withIdentifier: "ProfilView")
                            self.present(profilController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}

