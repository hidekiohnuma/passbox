import UIKit

class TransferHistoryDetailView: UIView {
    @IBOutlet weak var myLabel: UILabel!
    
    class func instance() -> TransferHistoryDetailView{
        return UINib(nibName: "TransferHistoryDetailView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! TransferHistoryDetailView
    }
}

