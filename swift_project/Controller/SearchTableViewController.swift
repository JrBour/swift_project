import UIKit
import Firebase

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var name: [String] = []
    var firstname: [String] = []
    var win: [Int] = []
    var lose: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataClassifications()
        let searchController = UISearchController(searchResultsController: nil) // Search Controller
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Rechercher..."
        
        if let url = URL(string: "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png") {
            downloadImage(url: url)
        }
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textField.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
                
            }
        }
    }
    
    /**
     * Set the data of classifications by retrieve informations in json files
     * @return Void
     */
    func setDataClassifications() -> Void {
        let friends = DataMapper.instance.friends
        for data in friends {
            self.name.append(data.name!)
            self.firstname.append(data.firstname!)
            self.lose.append(data.lose!)
            self.win.append(data.win!)
        }
    }

    /**
    * Get the picture by url
    * @param URL        The url of picture
    * @param closure
    * @return Void
    */
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Data) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in
            return data!
        }
    }
    
    /**
     * Count the number of cell to display
     * @param tableView      The UITableView class
     * @return int
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(name.count)
    }
    
    /**
     * Set the row height for each cell
     * @param tableView      The UITableView class
     * @param indexPath      The number of cell
     * @return CGFloat
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;//Choose your custom row height
    }
    
    /**
     * Param the table view cell
     * @param tableView      The UITableView class
     * @param indexPath      The number of cell to display
     * @return UITableViewCell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.userLabel.text = name[indexPath.row] + " " + firstname[indexPath.row]
        cell.resultLabel.text = String(win[indexPath.row]) + " victoires/" + String(lose[indexPath.row]) + " défaites"
        
        return(cell)
    }
}
