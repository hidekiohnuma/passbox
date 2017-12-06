import Foundation
import UIKit

class OrderContentController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ordercontentView = OrderContentView.instance()
        ordercontentView.frame = self.view.frame
        self.view.addSubview(ordercontentView)
        ordercontentView.myLabel.text = "test2"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
