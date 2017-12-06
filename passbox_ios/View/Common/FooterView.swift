import UIKit

class FooterView: UITabBar {
    class func instance() -> FooterView{
        return UINib(nibName: "FooterView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! FooterView
    }
}
