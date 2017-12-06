import Foundation
import UIKit

class TransferHistoryDetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let transferhistorydetailView = TransferHistoryDetailView.instance()
        transferhistorydetailView.frame = self.view.frame
        self.view.addSubview(transferhistorydetailView)
        transferhistorydetailView.myLabel.text = "test2"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
