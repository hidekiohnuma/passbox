import Foundation
import UIKit

class SelfIntroductionController: UIViewController,UITabBarDelegate,UINavigationBarDelegate {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var selfIntroductionCustomView: SelfIntroductionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selfIntroductionCustomView.delegate = self
        headerView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
extension SelfIntroductionController:SelfIntroductionViewDelegate {
    func buttonDidTap(text: String, sender: SelfIntroductionView) {
        print(text)
    }
}