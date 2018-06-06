import Foundation

class Classification: Decodable {
    var name : String?
    var points : String?
    
    init?(data: AnyObject) {
        let value = data as? NSDictionary
        
        if let name = value?["name"],
            let points = value?["points"]{
            
            self.name = name as? String ?? ""
            self.points = points as? String ?? ""
        }
    }
}
