import UIKit
import Firebase
import FirebaseStorage

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var allUsers: [User] = []
    var allFriends: [Friend] = []
    var allUsersId: [String] = []
    var win = [2, 5, 9, 0, 3, 5, 9]
    var lose = [10, 4, 8, 4, 2, 9, 1]
    var ref = Database.database().reference()
    var id: Int = 0
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil) // Search Controller
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Rechercher..."
        
        ref.child("users").observe(.value) { (snapshot) in
            for data in snapshot.children {
                self.allUsers.append(User(snapshot: data as AnyObject)!)
                let snap = data as! DataSnapshot
                self.allUsersId.append(snap.key)
            }
            self.ref.child("friends").queryOrdered(byChild: "friendsOne").queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.value) { (snapshot) in
                
                for data in snapshot.children {
                    self.allFriends.append(Friend(data: data as AnyObject)!)
                }
                
                self.allUsersId.filter({(value: String) in
                    for friend in self.allFriends {
                        if value == friend.friendTwo{
                            self.allUsers.remove(at: self.id)
                            self.id = self.id + 1
                            return false
                        }
                    }
                    if value == Auth.auth().currentUser?.uid{
                        self.allUsers.remove(at: self.id)
                        self.id = self.id + 1
                        return false
                    }
                    self.id = self.id + 1
                    return true
                })
                self.tableView.reloadData()
            }
            
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.userLabel.text = allUsers[indexPath.row].firstname! + " " + allUsers[indexPath.row].name!
        cell.addFriendButton.accessibilityIdentifier = self.allUsersId[indexPath.row]
        
        let profilPicture = self.imageReference.child(self.allUsers[indexPath.row].picture!)
        profilPicture.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                cell.userPicture.image = UIImage(data: data!)
                cell.userPicture.maskCircle(anyImage : cell.userPicture.image!)
            }
        }
        cell.resultLabel.text = String(win[indexPath.row]) + " victoires/" + String(lose[indexPath.row]) + " défaites"
        
        return(cell)
    }
}
