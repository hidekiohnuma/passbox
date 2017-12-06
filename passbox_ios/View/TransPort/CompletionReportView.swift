import UIKit

class CompletionReportView: UIView {
    class func instance() -> CompletionReportView{
        return UINib(nibName: "CompletionReportView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! CompletionReportView
    }
}
