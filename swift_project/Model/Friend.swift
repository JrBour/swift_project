import Foundation

class Friend: Decodable {
    var name : String?
    var firstname : String?
    var win : Int?
    var lose : Int?
    var picture : String?
    
    init?(data: AnyObject) {
        let value = data as? NSDictionary
        
        if let name = value?["name"],
            let firstname = value?["firstname"],
            let win = value?["win"],
            let lose = value?["lose"],
            let picture = value?["picture"] {
            
            self.name = name as? String ?? ""
            self.firstname = firstname as? String ?? ""
            self.win = win as? Int ?? 0
            self.lose = lose as? Int ?? 0
            self.picture = picture as? String ?? ""
        }
    }
}
