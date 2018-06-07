import Foundation
import Firebase

class Friend: Decodable {
    var friendOne: String?
    var friendTwo: String?
    
    init?(data: AnyObject) {
        var value = data as? NSDictionary
        if value == nil {
            let snap = data as! DataSnapshot
            value = snap.value as! [String: Any] as NSDictionary
        }
        
        if let friendOne = value?["friendsOne"],
            let friendTwo = value?["friendsTwo"] {
            
            self.friendOne = friendOne as? String ?? ""
            self.friendTwo = friendTwo as? String ?? ""
        }
    }
}
