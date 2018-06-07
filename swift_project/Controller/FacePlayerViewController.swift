import UIKit
import Firebase
import FirebaseStorage

class FacePlayerViewController: UIViewController {

    @IBOutlet weak var selectUserCollection: UICollectionView!
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
                    //self.collectionView.reloadData()
                })
            }
        }
    }
    
    
    /**
     * CollectionView function which return an integer
     * @param    collectionView              The collection view display in the storyboard
     * @param    numberOfItemsInSection      The number of items in the collection view
     * @return Int   The number of cells to display
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return(allUsers.count)
    }
    
    /**
     * Edit the style of cells in collection view when the user change the segment select
     * @param    collectionView         The collectoin view insert in the storyboard
     * @param    indexPath              The index of the current cell
     * @return   collectionView      Return the collectionView to display
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
//        cell.achievementLabel.text = secondTitleLabel[indexPath.row]
//        cell.numberLabel.text = secondNumberLabel[indexPath.row]
//        cell.backgroundColor = self.UIColorFromRGB(rgbValue: secondColorCell[indexPath.row])
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    /**
    * Go to the face player page
    * @param        sender      Informations send by the button
    * @return   Void
    */
    @IBAction func segueToSearchUser(_ sender: Any) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "SearchUser", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "NavBarSearchView")
        self.present(homeController, animated: true, completion: nil)
    }
    
    /**
     * Go back to the homepage
     * @param        sender      Informations send by the button
     * @return   Void
     */
    @IBAction func dismissFacePlayer(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let homeStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "TabBarView")
        self.present(homeController, animated: true, completion: nil)
    }
}
