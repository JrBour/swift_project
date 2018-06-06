import Foundation

class Answer {
//    var answerName: String?
//    var questionId: Int?
//    var result: Bool?
    let currentAnswerId: String
    
    init?(data: Any) {
        let value = data as? NSDictionary
        
//        let answerName = value?["answer_name"] as? String ?? ""
//        let questionId = value?["question_id"] as? Int ?? ""
//        let result = value?["result"] as? Bool ?? ""
        
        self.currentAnswerId = currentAnswerId
        
        
            
//            self.answerName = name as? String ?? ""
//            self.questionId = questionId as? Int ?? ""
//            self.result = result as? Bool ?? ""
        }
    
}
