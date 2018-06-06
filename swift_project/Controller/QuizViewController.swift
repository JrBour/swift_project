import UIKit
import Firebase

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    
    let firebaseAuth = Auth.auth()
    var pickedAnswer = false
    var questionNumber = 0
    var score: Int = 0
    var ref: DatabaseReference!
    var allQuestion: [QuestionBank] = []
    var allAnswer: [Answer] = []
    var currentQuestionId = Answer.init(data: <#T##Any#>)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestion[0]
        questionLabel.text = firstQuestion.name
        
        ref = Database.database().reference()
        
        ref.child("questions").queryOrdered(byChild: "quiz_id").queryEqual(toValue: 1).observe(.value){ (snapshot) in
            for data in snapshot.children {
                self.allQuestion.append(QuestionBank(data: data)!)
            }
        }
        
        ref.child("answer").queryOrdered(byChild: "question_id").queryEqual(toValue: 1).observe(.value) { (snapshot) in
            for data in snapshot.children {
                self.allAnswer.append(Answer(data: data)!)
            }
        }
    }
    
    
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        if sender.tag == 1 {
            pickedAnswer = true
            print("Oui")
        } else if sender.tag == 2 {
            pickedAnswer = false
            print("Non")
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 10"
        progressBarView.frame.size.width = (self.view.frame.width / 10) * CGFloat(questionNumber + 1)
        
    }
    
    func nextQuestion() {
        if questionNumber <= 9 {
            questionLabel.text = allQuestion[questionNumber].name
            updateUI()
        } else {
            let alert = UIAlertController(title: "Quiz terminé", message: "Voulez-vous recommencer le quiz ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Recommencer ?", style: .default) { (alertAction) in
                self.restart()
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer() {
        let correctAnswer = allAnswer.map({
            (value: Answer) in {
                return value.result == true
            }
        })
        
        print(correctAnswer)
        
        // Comparer
       //  CurrentQuestionId and result == true
        Answer.init(data: <#T##Any#>)
        
    }
    
    func restart() {
        // On utilise le plugin ProgresHub pour montrer le chargement
        //ProgressHUD.show("Chargement...")
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    
    
}
