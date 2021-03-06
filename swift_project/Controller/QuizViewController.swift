import UIKit
import Firebase

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var answerCollection: UICollectionView!
    
    var allQuestion: [QuestionBank] = []
    var allAnswer: [Answer] = []
    var currentAnswer: [Answer] = []
    let firebaseAuth = Auth.auth()
    var keyAnswer: [String] = []
    var lastKeyChallenge: String = ""
    var idChallenge: String = ""
    var idReceipter: String = ""
    var isReceipter: Bool = false
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
        
        questionLabel.numberOfLines = 10
        answerCollection.backgroundColor = UIColor.white
        
        ref.child("challenge").observe(.value){ (snapshot) in
            for data in snapshot.children {
                let snap = data as! DataSnapshot
                self.lastKeyChallenge = snap.key
            }
            print(self.lastKeyChallenge)
        }
        
        ref.child("question").queryOrdered(byChild: "quiz_id").queryEqual(toValue: 1).observe(.value){ (snapshot) in
            for data in snapshot.children {
                self.allQuestion.append(QuestionBank(data: data as AnyObject)!)
                let snap = data as! DataSnapshot
                self.keyAnswer.append(snap.key)
            }
            
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
    
    @IBAction func giveUpQuiz(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "TabBarView")
        self.present(homeController, animated: true, completion: nil)
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
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1    ).cgColor
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell.layer.shadowRadius = 20
        cell.layer.shadowOpacity = 1
        cell.layer.shouldRasterize = true
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
        progressBarView.frame.size.width = (self.view.frame.width / CGFloat(self.allQuestion.count)) * CGFloat(questionNumber + 1)
        
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
            var alert = UIAlertController(title: "Quiz terminé", message: "Receipterggtgtgt ?", preferredStyle: .alert)
            if isReceipter {
                self.ref.child("challenge").child("2").setValue([
                    "sender" : "ORnLn9VYDFbqDcKeobRhLmDZNo63",
                    "receipter" : "mN5jri6XTMa5GPdNI2XPVR0gIX22",
                    "senderPoints" : "20",
                    "receipterPoints" : "10",
                    "quizId" : 1,
                    "win" : "ORnLn9VYDFbqDcKeobRhLmDZNo63",
                    "complete" : true
                ])
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)
                
                let homeStoryboard = UIStoryboard(name: "Result", bundle: nil)
                let homeController = homeStoryboard.instantiateViewController(withIdentifier: "NavBarResultView")
                self.present(homeController, animated: true, completion: nil)

            } else {
                let id = Int(self.lastKeyChallenge)! + 1
                self.ref.child("challenge").child(String(id)).setValue([
                    "sender" : self.firebaseAuth.currentUser!.uid,
                    "receipter" : self.idReceipter,
                    "senderPoints" : self.score,
                    "receipterPoints" : "",
                    "quizId" : 1,
                    "win" : "",
                    "complete" : false
                ])
                alert = UIAlertController(title: "Quiz terminé", message: "Votre score est de \(score), l'invitation au défis a bien été envoyé a votre adversaire", preferredStyle: .alert)
            }
            let restartAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
                let homeStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                let homeController = homeStoryboard.instantiateViewController(withIdentifier: "TabBarView")
                self.present(homeController, animated: true, completion: nil)
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
        }
    }
}
