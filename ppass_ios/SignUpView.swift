import UIKit

class SignUpView: UIView {
    @IBOutlet weak var myLabel: UILabel!
    
    class func instance() -> SignUpView{
    return UINib(nibName: "SignUpView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! SignUpView
    }
}
