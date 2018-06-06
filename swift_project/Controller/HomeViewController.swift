import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var ref: DatabaseReference!
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToQuiz()
    }
    
    func goToQuiz() {
        let quizStoryboard = UIStoryboard(name: "Quiz", bundle: nil)
        let quizController = quizStoryboard.instantiateViewController(withIdentifier: "QuizView")
        self.present(quizController, animated: true, completion: nil)
    }
}
