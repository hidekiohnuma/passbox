import Foundation
import UIKit

class SearchController: UIViewController {
    
    
    @IBOutlet weak var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
extension SearchController: SearchViewDelegate {
    func searchButton(text: String, sender: SearchView) {
        print(text)
    }
}