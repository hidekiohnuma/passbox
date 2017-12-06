import UIKit

class WantedDetailView: UIView {
    @IBOutlet weak var myLabel: UILabel!
    
    class func instance() -> WantedDetailView{
        return UINib(nibName: "WantedDetailView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! WantedDetailView
    }
}
