import Foundation
import UIKit

class ProposalCompleteController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let proposalView = ProposalCompleteVIew.instance()
        proposalView.frame = self.view.frame
        self.view.addSubview(proposalView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
