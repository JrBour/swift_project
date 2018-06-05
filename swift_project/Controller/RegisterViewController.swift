import UIKit
import Firebase
import FirebaseStorage

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    var filename = ""
    
    @IBOutlet weak var nameFIeld: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pseudoField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.errorLabel.text = ""
        
        firebaseAuth.addStateDidChangeListener({ (firebaseAuth, user) in
            if user != nil && user != self.currentUser {
                self.currentUser = user
            }
        })
    }
    
    
    @IBAction func pickColor(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData:Data = UIImagePNGRepresentation(image_data!)!
        filename = UUID().uuidString + ".jpg"
        
        let uploadImageRef = imageReference.child(self.filename)
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            print ("Upload finished")
            print (metadata ?? "No metadata")
            print (error ?? "No error")
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
        uploadTask.resume()
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
                        "picture" : "images/"+self.filename,
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
