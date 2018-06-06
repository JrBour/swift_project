import UIKit
import Firebase

class ClassificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var username: [String] = []
    var level: [Int] = []
    var ref: DatabaseReference!
    let firebaseAuth = Auth.auth()
    
    @IBOutlet weak var levelTitleLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var classificationTable: UITableView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var winUserLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.setDataClassifications()
        
        classificationTable.delegate = self
        classificationTable.dataSource = self
        classificationTable.separatorStyle = UITableViewCellSeparatorStyle.none
        
        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let user = User(snapshot : value!)
            
            self.usernameLabel.text = (user?.name)!
            self.levelLabel.text = "Niveau " + String((user?.level)!) + " | "
            
        })
        
        ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 1).observeSingleEvent(of: .value, with: { snapshot in
            self.winUserLabel.text = String(snapshot.childrenCount) + " victoires"
        })
    }
    
    /**
    * Set the data of classifications by retrieve informations in json files
    * @return Void
    */
    func setDataClassifications() -> Void {
        let classifications = DataMapper.instance.classifications
        for data in classifications {
            self.username.append(data.name!)
            self.level.append(Int(data.points!)!)
        }
    }
    
    /**
    * Count the number of cell to display
    * @param tableView      The UITableView class
    * @return int
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(username.count)
    }
    
    /**
    * Set the row height for each cell
    * @param tableView      The UITableView class
    * @param indexPath      The number of cell
    * @return CGFloat
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0;//Choose your custom row height
    }
    
    /**
    * Param the table view cell
    * @param tableView      The UITableView class
    * @param indexPath      The number of cell to display
    * @return UITableViewCell
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.usernameClassification.text = username[indexPath.row]
        cell.levelClassification.text = String(level[indexPath.row])
        cell.numberClassification.text = String(indexPath.row + 1)
        
        return(cell)
    }
}
