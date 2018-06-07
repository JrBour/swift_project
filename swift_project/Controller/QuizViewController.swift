import UIKit
import Firebase

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var answerCollection: UICollectionView!
    
    let firebaseAuth = Auth.auth()
    var pickedAnswer = false
    var questionNumber = 0
    var score: Int = 0
    var ref: DatabaseReference!
    var allQuestion: [QuestionBank] = []
    var allAnswer: [Answer] = []
    var currentAnswer: [Answer] = []
    var selectAnswer: String = ""
    var keyAnswer: [String] = []
    var question: QuestionBank!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        ref.child("question").queryOrdered(byChild: "quiz_id").queryEqual(toValue: 1).observe(.value){ (snapshot) in
            for data in snapshot.children {
                self.allQuestion.append(QuestionBank(data: data as AnyObject)!)
                let snap = data as! DataSnapshot
                self.keyAnswer.append(snap.key)
            }
            self.question = self.allQuestion[0]
            self.questionLabel.text = self.question.name
            
            for answer in self.keyAnswer {
                self.ref.child("answer").queryOrdered(byChild: "question_id").queryEqual(toValue: Int(answer)).observe(.value) { (snapshot) in
                    for data in snapshot.children {
                        self.allAnswer.append(Answer(data: data as AnyObject)!)
                    }
                    self.progressLabel.text = "\(self.questionNumber) / \(self.allQuestion.count)"
                    self.currentAnswer = self.allAnswer.filter({
                        (value: Answer) in value.questionId == Int(self.keyAnswer[self.questionNumber])
                    })
                    print(self.currentAnswer)
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
        print(currentAnswer[indexPath.row].answerName)
        
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
        
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / \(allQuestion.count)"
        progressBarView.frame.size.width = (self.view.frame.width / 10) * CGFloat(questionNumber + 1)
        
    }
    
    func nextQuestion() {
        if questionNumber < allQuestion.count {
            self.currentAnswer = self.allAnswer.filter({
                (value: Answer) in value.questionId == Int(self.keyAnswer[self.questionNumber])
            })
            print(self.currentAnswer)
            self.answerCollection.reloadData()
            
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
    
    /**
    * Check if the answer select is the good answer
    * @return Void
    */
    func checkAnswer() {
        let correctAnswer = allAnswer.filter({
            (value: Answer) in value.result == true && value.questionId == Int(self.keyAnswer[self.questionNumber])
        })
        
        if correctAnswer[0].answerName == selectAnswer {
            print("bonne réponse")
        } else {
            print("mauvais réponse")
        }
    }
    
    func restart() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    
    
}
