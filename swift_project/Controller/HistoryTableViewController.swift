import UIKit
import Firebase

class HistoryTableViewController: UITableViewController {

    var ref = Database.database().reference()
    var currentUser: Firebase.User?
    let firebaseAuth = Auth.auth()
    var allChallenges: [Challenge] = []
    var allUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("challenge").queryOrdered(byChild: "receipter").queryEqual(toValue: firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { snapshot in
            for data in snapshot.children {
                self.allChallenges.append(Challenge(data: data as AnyObject)!)
            }
            self.allChallenges = self.allChallenges.filter({
                (value: Challenge) in
                if value.complete == true {
                    return false
                }
                return true
            })
            for receipter in self.allChallenges {
                self.ref.child("users").child(receipter.receipter!).observeSingleEvent(of: .value, with: { snapshot in
                    let value = snapshot.value as? NSDictionary
                    self.allUsers.append(User(snapshot: value!)!)
                    print(self.allUsers.count)
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    @objc func goToQuiz() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let quizStoryboard = UIStoryboard(name: "Quiz", bundle: nil)
        let homeController = quizStoryboard.instantiateViewController(withIdentifier: "QuizView")
        
        let myVC = quizStoryboard.instantiateViewController(withIdentifier: "QuizView") as! QuizViewController
        myVC.isReceipter = true
        self.present(myVC, animated: true, completion: nil)
    }
    
    @IBAction func dimissPage(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    /**
     * Count the number of cell to display
     * @param tableView      The UITableView class
     * @return int
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(allUsers.count)
    }
    
    /**
     * Set the row height for each cell
     * @param tableView      The UITableView class
     * @param indexPath      The number of cell
     * @return CGFloat
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    /**
     * Param the table view cell
     * @param tableView      The UITableView class
     * @param indexPath      The number of cell to display
     * @return UITableViewCell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToQuiz))
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.usernameChallengeSend.text = "Défis lancés"
        cell.challengeSend.text = allUsers[indexPath.row].username! + " vous lance un défi !"
        cell.addGestureRecognizer(tapGesture)
        
        return(cell)
    }

    
}
