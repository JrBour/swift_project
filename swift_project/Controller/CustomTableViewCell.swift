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
    
    @IBOutlet weak var usernameChallengeSend: UILabel!
    @IBOutlet weak var challengeSend: UILabel!
    
}
