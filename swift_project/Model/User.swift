import UIKit
import Firebase

class User {
    var name: String?
    var firstname: String?
    var username: String?
    var country: String?
    var picture: String?
    var experience: Int?
    var level: Int?
    
    init?(snapshot: AnyObject) {
        var value = snapshot as? NSDictionary
        if value == nil {
            let snap = snapshot as! DataSnapshot
            value = snap.value as! [String: Any] as NSDictionary
        }
        
        if let name = value?["name"],
            let firstname = value?["firstname"],
            let username = value?["username"],
            let country = value?["country"],
            let picture = value?["picture"],
            let experience = value?["experience"],
            let level = value?["level"] {

            self.name = name as? String ?? ""
            self.firstname = firstname as? String ?? ""
            self.username = username as? String ?? ""
            self.country = country as? String ?? ""
            self.picture = picture as? String ?? ""
            self.experience = experience as? Int ?? 0
            self.level = level as? Int ?? 0
        }
    }
}
