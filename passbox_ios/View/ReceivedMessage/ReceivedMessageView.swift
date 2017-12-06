import UIKit

class ReceivedMessageView: UIView {
    class func instance() -> ReceivedMessageView{
        return UINib(nibName: "ReceivedMessageView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! ReceivedMessageView
    }
}
