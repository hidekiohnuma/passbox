import Foundation
import UIKit

class WantedDetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wanteddetailView = WantedDetailView.instance()
        wanteddetailView.frame = self.view.frame
        self.view.addSubview(wanteddetailView)
        wanteddetailView.myLabel.text = "test2"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
