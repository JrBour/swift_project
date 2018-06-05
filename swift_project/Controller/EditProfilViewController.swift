import UIKit
import Firebase
import FirebaseStorage

class EditProfilViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    var filename = ""
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }

    @IBOutlet weak var profilPicture: UIImageView!
    @IBOutlet weak var titleNavBar: UINavigationItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var editProfilPictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.editProfilPictureButton.layer.cornerRadius = 0.5 * self.editProfilPictureButton.bounds.size.width
        self.editProfilPictureButton.backgroundColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 0.3)
        
        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            self.usernameField.text = value?["username"] as? String ?? ""
            self.nameField.text = value?["name"] as? String ?? ""
            self.mailField.text = value?["email"] as? String ?? ""
            self.firstNameField.text = value?["firstname"] as? String ?? ""
            self.countryField.text = value?["country"] as? String ?? ""
            self.filename = value?["picture"] as? String ?? ""
            
            let profilPicture = self.imageReference.child(self.filename)
            profilPicture.getData(maxSize: 15 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    self.profilPicture.image = UIImage(data: data!)
                    self.profilPicture.maskCircle(anyImage : self.profilPicture.image!)
                }
            }
            
        })
    }
    
    @IBAction func editProfilPicture(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    /**
    * This function allow to store the profil picture
    * @param    picker      The image picker controller
    * @param    info        The informations on the picture
    * @return   void
    */
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
     * Cancel the modification of the current profil user and segue to profil page
     * @param       sender      The informations send by the cancel button
     * @return void
     */
    @IBAction func cancelEditProfil(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
    * Save the new informations of the current user and segue to the profil page
    * @param    sender      The informations send by the save button
    * @return void
    */
    @IBAction func saveNewInformations(_ sender: Any) {
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
                        "picture" : self.filename
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
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}

