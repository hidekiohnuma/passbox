import UIKit

class OrderContentView: UIView {
    @IBOutlet weak var myLabel: UILabel!
    
    class func instance() -> OrderContentView{
        return UINib(nibName: "OrderContentView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! OrderContentView
    }
}
