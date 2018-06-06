import UIKit
import Firebase
import FirebaseStorage

class QuestionBank {
    var name : String?
    
    init?(data: AnyObject){
        let snap = data as! DataSnapshot
        let value = snap.value as! [String: Any]
        
        print(value)
        if let name = value["question_name"] {
            print("insertion")
            self.name = name as? String ?? ""
        }
    }
}

