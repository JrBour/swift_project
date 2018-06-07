import UIKit
import Firebase

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var numberClassification: UILabel!
    @IBOutlet weak var usernameClassification: UILabel!
    @IBOutlet weak var levelClassification: UILabel!
    
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var pictureFriendImage: UIImageView!
    @IBOutlet weak var userFriendLabel: UILabel!
    @IBOutlet weak var userFriendResult: UILabel!
    
    @IBAction func addFriend(_ sender: UIButton) {
        let ref = Database.database().reference()
        
        ref.child("friends").childByAutoId().setValue([
            "friendsOne" : Auth.auth().currentUser?.uid,
            "friendsTwo" : sender.accessibilityIdentifier!
        ])
    }
    
}
