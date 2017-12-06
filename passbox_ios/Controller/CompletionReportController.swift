import Foundation
import UIKit

class CompletionReportController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let completionreportView = CompletionReportView.instance()
        completionreportView.frame = self.view.frame
        self.view.addSubview(completionreportView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
