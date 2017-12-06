import UIKit

class CommonWebView: UIWebView {
    class func instance() -> CommonWebView{
        return UINib(nibName: "CommonWebView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! CommonWebView
    }
}
