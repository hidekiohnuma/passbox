import UIKit

class ProposalCompleteVIew: UIView {
    
    class func instance() -> ProposalCompleteVIew{
        return UINib(nibName: "ProposalCompleteVIew", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! ProposalCompleteVIew
    }
}
