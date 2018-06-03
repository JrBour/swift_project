import Firebase
import UIKit

class ProfilViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let firebaseAuth = Auth.auth()
    var ref: DatabaseReference!
    
    @IBOutlet weak var achievementCollection: UICollectionView!
    
    @IBOutlet weak var editProfil: UIButton!
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
        ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 0).observeSingleEvent(of: .value, with: { snapshot in
            self.thirdNumberLabel[0] = String(snapshot.childrenCount)
        })
        
        ref.child("quiz-user").queryOrdered(byChild: "win").queryEqual(toValue: 1).observeSingleEvent(of: .value, with: { snapshot in
            self.thirdNumberLabel[1] = String(snapshot.childrenCount)
        })

        ref.child("users").child(firebaseAuth.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let level = value?["level"] as? Int
            let experience = value?["experience"] as? Int
            let username = value?["username"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let firstname = value?["firstname"] as? String ?? ""
            let country = value?["country"] as? String ?? ""
            
            self.usernameLabel.text = "Pseudo : " + String(username)
            self.nameLabel.text = "Nom : " + String(name)
            self.firstnameLabel.text = "Prénom : " + String(firstname)
            self.countryLabel.text = "Pays : " + String(country)
            self.levelLabel.text = "Niveau " + String(describing: level!)
            self.thirdNumberLabel[2] = String(describing: experience!)
            
            self.titleUsernameLabel.text = value?["username"] as? String ?? ""
            
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secondTitleLabel.count
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
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
    *
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
    *
    */
    func setUpView() {
        self.editProfil.layer.cornerRadius = 10
        self.editProfil.clipsToBounds = true
        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
//        self.navbarProfil.backgroundColor = .clear
//        self.navbarProfil.tintColor = .clear
//        self.navbarProfil.setTitleTextAttributes([
//            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
//            NSAttributedStringKey.foregroundColor: UIColor.black
//        ], for: .normal)
//
//        self.navbarProfil.setTitleTextAttributes([
//            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
//            NSAttributedStringKey.foregroundColor: UIColor.orange
//        ], for: .selected)

        
    }
}
