import UIKit

class ProposalView: UIView,UITextFieldDelegate  {
    
    weak var delegate: ProposalViewDelegate! = nil
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    override func awakeFromNib() {
        // XIB読み込み
        let view = NSBundle.mainBundle().loadNibNamed("ProposalView", owner: self, options: nil).first as! UIView
        addSubview(view)
        self.textField1.delegate = self
        self.textField2.delegate = self
        
    }
    
    @IBAction func sendButton(sender: UIButton) {
        delegate?.buttonDidTap(textField1.text!, sender: self)
        delegate?.buttonDidTap(textField2.text!, sender: self)
    }

}

protocol ProposalViewDelegate: class {
    func buttonDidTap(text: String, sender: ProposalView)
}