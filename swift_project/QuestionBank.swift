import UIKit
import Firebase
import FirebaseStorage

class QuestionBank {
    
    var name : String?
    
    init?(data: Any){
        let value = data as? NSDictionary
        
        if let name = value?["name"] {
            self.name = name as? String ?? ""
        }
    }
}

