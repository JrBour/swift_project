import Foundation
import Firebase

class Challenge: Decodable {
    var sender: String?
    var receipter: String?
    var senderPoints: Int?
    var receipterPoints: Int?
    var quizId: Int?
    var win: String?
    var complete: Bool?
    
    init?(data: AnyObject) {
        var value = data as? NSDictionary
        if value == nil {
            let snap = data as! DataSnapshot
            value = snap.value as! [String: Any] as NSDictionary
        }
        
        if let sender = value?["sender"],
            let receipter = value?["receipter"],
            let senderPoints = value?["senderPoints"],
            let receipterPoints = value?["receipterPoints"],
            let quizId = value?["quizId"],
            let win = value?["win"],
            let complete = value?["complete"] {
            
            self.sender = sender as? String ?? ""
            self.receipter = receipter as? String ?? ""
            self.senderPoints = senderPoints as? Int ?? 0
            self.receipterPoints = receipterPoints as? Int ?? 0
            self.quizId = quizId as? Int ?? 0
            self.win = win as? String ?? ""
            self.complete = complete as? Bool ?? false
        }
        
    }
}
