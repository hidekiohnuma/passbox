import UIKit

class RecruitmentDetailShippingView: UIView {
    
    
    class func instance() -> RecruitmentDetailShippingView{
        return UINib(nibName: "RecruitmentDetailShippingView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! RecruitmentDetailShippingView
    }
    
    
}
