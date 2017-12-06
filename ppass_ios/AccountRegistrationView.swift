import UIKit

class AccountRegistrationView: UIView,UITextFieldDelegate {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    
    weak var delegate: AccountCustomSendValueDelegate! = nil
    
    override func awakeFromNib() {
        // XIB読み込み
        let view = NSBundle.mainBundle().loadNibNamed("AccountRegistrationView", owner: self, options: nil).first as! UIView
        addSubview(view)
    }
    @IBAction func sendButton(sender: UIButton) {
        delegate?.sendValue(textField1.text!,text2: textField2.text!,text3: textField3.text!, sender: self)
    }
    
}
//データ送信
protocol AccountCustomSendValueDelegate: class {
    func sendValue(text1: String,text2: String,text3: String,sender: AccountRegistrationView)
}