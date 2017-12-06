//空き登録完了
import UIKit

class FreeRegistrationCompleteView: UIView {
    class func instance() -> FreeRegistrationCompleteView{
        return UINib(nibName: "FreeRegistrationCompleteView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! FreeRegistrationCompleteView
    }
}
