import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ref: DatabaseReference!
    
    override init() {
        super.init()
        FirebaseApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ref = Database.database().reference()
        
        // this is how we build out our app in code
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        //        let randomViewController = UIViewController()
        //        randomViewController.view.backgroundColor = .purple
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = SwipingController(collectionViewLayout: layout)
        
        window?.rootViewController = swipingController
        
        return true
    }

}

