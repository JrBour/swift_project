import Foundation

class Challenge: Decodable {
    var firstnameFirst: String?
    var nameFirst: String?
    var firstnameSecond: String?
    var nameSecond: String?
    var pictureFirst: String?
    var pictureSecond: String?
    var win: Int?
    var points: String?
    
    init?(data: AnyObject) {
        let value = data as? NSDictionary
        
    }
}
