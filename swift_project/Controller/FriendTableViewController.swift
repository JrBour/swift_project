import UIKit
import Firebase
import FirebaseStorage

class FriendTableViewController: UITableViewController {
    
    var ref = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    var allFriends: [Friend] = []
    var allUsers: [User] = []
    var win: [Int] = [10, 3, 8, 9]
    var lose: [Int] = [2, 3, 5, 2]
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("friends").queryOrdered(byChild: "friendsOne").queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.value) { (snapshot) in
            for data in snapshot.children {
                self.allFriends.append(Friend(data: data as AnyObject)!)
            }
            for friend in self.allFriends {
                self.ref.child("users").child(friend.friendTwo!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    self.allUsers.append(User(snapshot: value!)!)
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    /**
    * Dismiss the friend page and go back to profil page
    * @param        sender      The informations send by the button
    * @return   Void
    */
    @IBAction func dismissFriendPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /**
     * Count the number of cell to display
     * @param tableView      The UITableView class
     * @return int
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(allUsers.count)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.userFriendLabel.text = allUsers[indexPath.row].firstname! + " " + allUsers[indexPath.row].name!
        
        let profilPicture = self.imageReference.child(self.allUsers[indexPath.row].picture!)
        profilPicture.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                cell.pictureFriendImage.image = UIImage(data: data!)
                cell.pictureFriendImage.maskCircle(anyImage : cell.pictureFriendImage.image!)
            }
        }
        cell.userFriendResult.text = String(win[indexPath.row]) + " victoires/" + String(lose[indexPath.row]) + " défaites"
        
        return(cell)
    }

}
