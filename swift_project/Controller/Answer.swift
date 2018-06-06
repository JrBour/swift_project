import Foundation

class Answer {
    var answerName: String?
    var questionId: Int?
    var result: Bool?
    
    init?(data: Any) {
        let value = data as? NSDictionary
        
        if let name = value?["name"],
        let questionId = value?["question_id"],
            let result = value?["result"] {
            
            self.answerName = name as? String ?? ""
            self.questionId = questionId as? Int ?? 0
            self.result = result as? Bool
        }

    }
}
