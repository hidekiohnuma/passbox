import UIKit

class SignUpDetailView: UIView {
    @IBOutlet weak var myLabel: UILabel!
    
    class func instance() -> SignUpDetailView{
        return UINib(nibName: "SignUpDetailView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! SignUpDetailView
    }
}
