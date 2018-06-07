import Foundation
import Firebase

class Answer {
    var answerName: String?
    var questionId: Int?
    var result: Bool?
    
    init?(data: AnyObject) {
        let snap = data as! DataSnapshot
        let value = snap.value as! [String: Any]
        
        if let name = value["answer_name"],
        let questionId = value["question_id"],
            let result = value["result"] {
            
            self.answerName = name as? String ?? ""
            self.questionId = questionId as? Int ?? 0
            self.result = result as? Bool
        }

    }
}
