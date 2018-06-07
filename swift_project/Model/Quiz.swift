import Foundation
import Firebase

class Quiz {
    var name: String?
    var points: Int?
    
    init?(data: AnyObject){
        let value = data as? NSDictionary
        if let name = value?["name"],
            let points = value?["points"]{
            self.name = name as? String ?? ""
            self.points = points as? Int ?? 0
        }
    }
}
