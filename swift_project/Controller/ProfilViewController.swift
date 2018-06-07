import UIKit
import Firebase
import FirebaseStorage

class ProfilViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    let firebaseAuth = Auth.auth()
    var ref: DatabaseReference!
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    @IBOutlet weak var achievementCollection: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var profilPicture: UIImageView!
    
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var navbarProfil: UISegmentedControl!
    @IBOutlet weak var titleUsernameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    let secondTitleLabel = ["Ligue des champions", "Coupe du monde", "Liga", "Ballons d'or"]
    var secondNumberLabel = ["03", "01", "08", "02"]
    let secondColorCell: [UInt] = [0x545454, 0xF58278, 0x2C88EC, 0xE5B673]
    let thirdTitleLabel = ["Défaites", "Victoires", "Points d'expérience", "Quiz"]
    var thirdNumberLabel = ["02", "58", "", "03"]
    let thirdColorCell: [UInt] = [0x4A7E7A, 0x47D35B, 0xFC5759, 0x3AD3D6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        navbarProfil.addUnderlineForSelectedSegment()
        
        achievementCollection.delegate = self
        achievementCollection.dataSource = self
        
        ref = Database.database().reference()
        navbarProfil.selectedSegmentIndex = 0
        achievementCollection.isHidden = true
        
        ref.child("friends").queryOrdered(byChild: "friendsOne").queryEqual(toValue: firebaseAuth.currentUser?.uid).observeSingleEvent(of: .value, with: { snapshot in
             self.friendButton.setTitle(String(snapshot.childrenCount) + " amis", for: .normal)
        })
        
        ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 0).observeSingleEvent(of: .value, with: { snapshot in
            self.thirdNumberLabel[0] = String(snapshot.childrenCount)
        })
        
        ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 1).observeSingleEvent(of: .value, with: { snapshot in
            self.thirdNumberLabel[1] = String(snapshot.childrenCount)
        })
            
        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let user = User(snapshot : value!)
            
            let profilPicture = self.imageReference.child((user?.picture)!)
            profilPicture.getData(maxSize: 15 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    self.profilPicture.image = UIImage(data: data!)
                    self.profilPicture.maskCircle(anyImage : self.profilPicture.image!)
                }
            }
            self.usernameLabel.text = "Pseudo : " + (user?.username)!
            self.nameLabel.text = "Nom : " + (user?.name)!
            self.firstnameLabel.text = "Prénom : " + (user?.firstname)!
            self.countryLabel.text = "Pays : " + (user?.country)!
            self.levelLabel.text = "Niveau " + String((user?.level)!)
            
            self.titleUsernameLabel.text = (user?.username)!
            
        })
    }
    
    /**
    * Go to friend page
    * @param    sender      The informations send by the button
    * @return Void
    */
    @IBAction func goToFriendPage(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let friendStoryboard = UIStoryboard(name: "Friend", bundle: nil)
        let friendController = friendStoryboard.instantiateViewController(withIdentifier: "NavBarFriendView")
        self.present(friendController, animated: true, completion: nil)
    }
    
    /**
    * CollectionView function which return an integer
    * @param    collectionView              The collection view display in the storyboard
    * @param    numberOfItemsInSection      The number of items in the collection view
    * @return Int   The number of cells to display
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secondTitleLabel.count
    }
    
    /**
    * Transform the UIColor in RGB
    * @param    rgbValue        The rgb value to change
    * @return UIColor       The RGB Color transform in UIColor
    */
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /**
    * Edit the style of cells in collection view when the user change the segment select
    * @param    collectionView         The collectoin view insert in the storyboard
    * @param    indexPath              The index of the current cell
    * @return   collectionView      Return the collectionView to display
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if navbarProfil.selectedSegmentIndex == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
            cell.achievementLabel.text = secondTitleLabel[indexPath.row]
            cell.numberLabel.text = secondNumberLabel[indexPath.row]
            cell.backgroundColor = self.UIColorFromRGB(rgbValue: secondColorCell[indexPath.row])
            cell.layer.cornerRadius = 8
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
            cell.achievementLabel.text = thirdTitleLabel[indexPath.row]
            cell.numberLabel.text = thirdNumberLabel[indexPath.row]
            cell.backgroundColor = self.UIColorFromRGB(rgbValue: thirdColorCell[indexPath.row])
            cell.layer.cornerRadius = 8
            
            return cell
        }
    }
    
    /**
    * Change the informations display
    * @param    Sender      The informations send by the segment controller
    * @return  void
    */
    @IBAction func changeInformations(_ sender: Any) {
        let labels: [UIView] = [usernameLabel, nameLabel, countryLabel, firstnameLabel]
        self.navbarProfil.changeUnderlinePosition()
        
        if navbarProfil.selectedSegmentIndex == 0 {
            for  label in labels {
                label.isHidden = false
            }
            achievementCollection.isHidden = true
        } else if navbarProfil.selectedSegmentIndex == 1 {
            for  label in labels {
                label.isHidden = true
            }
            self.achievementCollection.reloadData()
            achievementCollection.isHidden = false
        } else if navbarProfil.selectedSegmentIndex == 2 {
            for  label in labels {
                label.isHidden = true
            }
            self.achievementCollection.reloadData()
            achievementCollection.isHidden = false
        }
    }
    
    /**
    * Sign out the current user
    * @param    Sender      Contain the action send by the logout button
    */
    @IBAction func logout(_ sender: Any) {
        do {
            try firebaseAuth.signOut()
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginController = loginStoryboard.instantiateViewController(withIdentifier: "LoginView")
            self.present(loginController, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    /**
    * Set up the corener radius of bouton
    * @return void
    */
    func setUpView() {
        self.friendButton.layer.cornerRadius = 10
        self.friendButton.clipsToBounds = true
        self.navigationBar.title = "Profil"
    }
}
