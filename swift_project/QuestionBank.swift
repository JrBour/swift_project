import UIKit
import Firebase

class QuestionBank {
    var name : String?
    
    init?(data: AnyObject){
        let snap = data as! DataSnapshot
        let value = snap.value as! [String: Any]
        
        if let name = value["question_name"] {
            self.name = name as? String ?? ""
        }
    }
}

