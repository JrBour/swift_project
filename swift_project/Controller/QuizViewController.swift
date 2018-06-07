import UIKit
import Firebase

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var answerCollection: UICollectionView!
    
    var allQuestion: [QuestionBank] = []
    var allAnswer: [Answer] = []
    var currentAnswer: [Answer] = []
    let firebaseAuth = Auth.auth()
    var keyAnswer: [String] = []
    var pointsByQuestion: Int = 0
    var question: QuestionBank!
    var questionNumber = 0
    var quiz: Quiz!
    var ref: DatabaseReference!
    var selectAnswer: String = ""
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        ref.child("question").queryOrdered(byChild: "quiz_id").queryEqual(toValue: 1).observe(.value){ (snapshot) in
            for data in snapshot.children {
                self.allQuestion.append(QuestionBank(data: data as AnyObject)!)
                let snap = data as! DataSnapshot
                self.keyAnswer.append(snap.key)
            }
            
            print(self.pointsByQuestion)
            self.question = self.allQuestion[0]
            self.questionLabel.text = self.question.name
            
            self.ref.child("quiz").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.quiz = Quiz(data: value!)
                
                self.pointsByQuestion = ((self.quiz.points)!/self.allQuestion.count)
            })
            
            for answer in self.keyAnswer {
                self.ref.child("answer").queryOrdered(byChild: "question_id").queryEqual(toValue: Int(answer)).observe(.value) { (snapshot) in
                    for data in snapshot.children {
                        self.allAnswer.append(Answer(data: data as AnyObject)!)
                    }
                    self.progressLabel.text = "\(self.questionNumber) / \(self.allQuestion.count)"
                    self.currentAnswer = self.allAnswer.filter({
                        (value: Answer) in value.questionId == Int(self.keyAnswer[self.questionNumber])
                    })
                    self.answerCollection.delegate = self
                    self.answerCollection.dataSource = self
                    self.answerCollection.reloadData()
                }
            }
        }
    }
    
    /**
     * @param    collectionView              The collection view display in the storyboard
     * @param    numberOfItemsInSection      The number of items in the collection view
     * @return Int   The number of cells to display
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentAnswer.count
    }
    
    /**
     * Edit the style of cells in collection view when the user change the segment select
     * @param    collectionView         The collectoin view insert in the storyboard
     * @param    indexPath              The index of the current cell
     * @return   collectionView      Return the collectionView to display
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        cell.answerButton.setTitle(currentAnswer[indexPath.row].answerName,for: .normal)
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    /**
    * Send the informations on the controller when the button is tapped
    * @param    UIButton        The information sent by the UIButton
    * @return Void
    */
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let button = sender as UIButton // as! for Swift 1.2
        selectAnswer = button.titleLabel!.text!
        
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
    }
    
    /**
    * Update the storyboard
    * @return Void
    */
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / \(allQuestion.count)"
        progressBarView.frame.size.width = (self.view.frame.width / 10) * CGFloat(questionNumber + 1)
        
    }
    
    /**
    * Checks whether or not there are any questions left
    * @return Void
    */
    func nextQuestion() -> Void {
        if questionNumber < allQuestion.count {
            self.currentAnswer = self.allAnswer.filter({
                (value: Answer) in value.questionId == Int(self.keyAnswer[self.questionNumber])
            })
            
            self.answerCollection.reloadData()
            questionLabel.text = allQuestion[questionNumber].name
            updateUI()
        } else {
            let alert = UIAlertController(title: "Quiz terminé", message: "Voulez-vous recommencer le quiz ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Recommencer ?", style: .default) { (alertAction) in
                print("nope")
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    /**
    * Check if the answer select is the good answer
    * @return Void
    */
    func checkAnswer() {
        let correctAnswer = allAnswer.filter({
            (value: Answer) in value.result == true && value.questionId == Int(self.keyAnswer[self.questionNumber])
        })
        
        if correctAnswer[0].answerName == selectAnswer {
            self.score = self.score + self.pointsByQuestion
            print("bonne réponse")
        } else {
            print("mauvais réponse")
        }
    }
}
