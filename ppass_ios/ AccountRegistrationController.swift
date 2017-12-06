import Foundation
import UIKit

class  AccountRegistrationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let accountregistrationView =  AccountRegistrationView.instance()
        accountregistrationView.frame = self.view.frame
        self.view.addSubview(accountregistrationView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
