import UIKit

class SelfIntroductionView: UIView {
    
    @IBOutlet weak var selfIntroductionText: UITextField!
    
    weak var delegate: SelfIntroductionViewDelegate! = nil
    
    override func awakeFromNib() {
        // XIB読み込み
        let view = NSBundle.mainBundle().loadNibNamed("SelfIntroductionView", owner: self, options: nil).first as! UIView
        addSubview(view)
    }
    @IBAction func sendButton(sender: UIButton) {
        delegate?.buttonDidTap(selfIntroductionText.text!, sender: self)
    }
   
}
protocol SelfIntroductionViewDelegate: class {
    func buttonDidTap(text: String, sender: SelfIntroductionView)
}
