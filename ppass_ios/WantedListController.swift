import Foundation
import UIKit

class WantedListController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wantedlistView = WantedListView.instance()
        wantedlistView.frame = self.view.frame
        self.view.addSubview(wantedlistView)
        wantedlistView.myLabel.text = "test2"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
