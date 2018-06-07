import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "bear_first", headerText: "Challengez vos amis", bodyText: "Envoyer des défis sur le foot à vos amis.Ces derniers pourront vous challenger en retour"),
        Page(imageName: "heart_second", headerText: "Redecouvrez le foot", bodyText: "Le foot c’est une longue histoire entre un ballon et des joueurs."),
        Page(imageName: "leaf_third", headerText: "Devenez un champion", bodyText: "Obtenez des trophées et des badges à l’issue de vos matchs. Plus vous en aurez plus on vous reconnaîtra parmi les grands"),
    ]
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("S'incrire", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
//    @objc private func handlePrev() {
//        let nextIndex = max(pageControl.currentPage - 1, 0)
//        let indexPath = IndexPath(item: nextIndex, section: 0)
//        pageControl.currentPage = nextIndex
//        if pageControl.currentPage == 0 {
//            self.collectionView?.backgroundColor = UIColor(red: 4/255, green: 170/255, blue: 92/255, alpha: 1)
//        } else if pageControl.currentPage == 1 {
//            self.collectionView?.backgroundColor = UIColor(red: 10/255, green: 138/255, blue: 188/255, alpha: 1)
//        } else if pageControl.currentPage == 2 {
//            self.collectionView?.backgroundColor = UIColor(red: 215/255, green: 82/255, blue: 45/255, alpha: 1)
//        }
//
//        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
    
    private let connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Se connecter", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        //button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
//    @objc private func handleNext() {
//        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
//        let indexPath = IndexPath(item: nextIndex, section: 0)
//        pageControl.currentPage = nextIndex
//
//        if pageControl.currentPage == 0 {
//            self.collectionView?.backgroundColor = UIColor(red: 4/255, green: 170/255, blue: 92/255, alpha: 1)
//        } else if pageControl.currentPage == 1 {
//            self.collectionView?.backgroundColor = UIColor(red: 10/255, green: 255/255, blue: 0/255, alpha: 1)
//        } else if pageControl.currentPage == 2 {
//            self.collectionView?.backgroundColor = UIColor(red:255/255, green: 255/255, blue: 0/255, alpha: 1)
//        }
//        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainWhite
        pc.pageIndicatorTintColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
        
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [loginButton, pageControl, connectButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        // bottomControlsStackView.layoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            //bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    // Gère la pagination scroll
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let x = targetContentOffset.pointee.x

        pageControl.currentPage = Int(x / view.frame.width)
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        _ = IndexPath(item: nextIndex, section: 0)
        
        if pageControl.currentPage == 0 {
            self.collectionView?.backgroundColor = UIColor(red: 4/255, green: 170/255, blue: 92/255, alpha: 1)
        } else if pageControl.currentPage == 1 {
            self.collectionView?.backgroundColor = UIColor(red: 10/255, green: 138/255, blue: 188/255, alpha: 1)
        } else if pageControl.currentPage == 2 {
            self.collectionView?.backgroundColor = UIColor(red: 215/255, green: 82/255, blue: 45/255, alpha: 1)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        
        collectionView?.backgroundColor = UIColor(red: 4/255, green: 170/255, blue: 92/255, alpha: 1)
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
    
}
