import UIKit

class WantedListView: UIView {
    @IBOutlet weak var myLabel: UILabel!
    
    class func instance() -> WantedListView{
        return UINib(nibName: "WantedListView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! WantedListView
    }
}
