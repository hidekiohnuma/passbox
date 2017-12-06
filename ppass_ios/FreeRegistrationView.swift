//空き登録
import UIKit

class FreeRegistrationView: UIView,UIPickerViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!//車種
    
    var pickOption = ["平型", "バン型", "ウィング型", "保冷車", "冷凍車","車載車","重機運搬車","危険物運搬車","ダンプ","幌","ユニック","海上コンテナ","その他","希望無し"]
    
    weak var delegate: CustomViewDelegate! = nil

    override func awakeFromNib() {
        // XIB読み込み
        let view = NSBundle.mainBundle().loadNibNamed("FreeRegistrationView", owner: self, options: nil).first as! UIView
        addSubview(view)
        let datePicker = UIDatePicker()
        let datePicker4 = UIDatePicker()
        let datePicker5 = UIDatePicker()
        let selectPicker = UIPickerView()
        selectPicker.delegate = self
        textField1.inputView = datePicker
        textField4.inputView = datePicker4
        textField5.inputView = datePicker5
        textField6.inputView = selectPicker
        
        self.textField1.delegate = self
        self.textField2.delegate = self
        self.textField3.delegate = self
        self.textField4.delegate = self
        self.textField5.delegate = self
        self.textField6.delegate = self
        
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP")
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        datePicker4.locale = NSLocale(localeIdentifier: "ja_JP")
        datePicker4.addTarget(self, action: Selector("datePickerValueChanged4:"), forControlEvents: UIControlEvents.ValueChanged)
        datePicker5.locale = NSLocale(localeIdentifier: "ja_JP")
        datePicker5.addTarget(self, action: Selector("datePickerValueChanged5:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter1 = NSDateFormatter()
        dateFormatter1.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter1.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter1.timeStyle = NSDateFormatterStyle.MediumStyle
        textField1.text = dateFormatter1.stringFromDate(sender.date)
    }
    func datePickerValueChanged4(sender:UIDatePicker) {
        let dateFormatter4 = NSDateFormatter()
        dateFormatter4.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter4.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter4.timeStyle = NSDateFormatterStyle.MediumStyle
        textField4.text = dateFormatter4.stringFromDate(sender.date)
    }
    func datePickerValueChanged5(sender:UIDatePicker) {
        let dateFormatter5 = NSDateFormatter()
        dateFormatter5.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter5.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter5.timeStyle = NSDateFormatterStyle.MediumStyle
        textField5.text = dateFormatter5.stringFromDate(sender.date)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField6.text = pickOption[row]
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        //        return false
        
    }
    
    @IBAction func sendButton(sender: UIButton) {
        delegate?.buttonDidTap(textField1.text!, sender: self)
        delegate?.buttonDidTap(textField2.text!, sender: self)
        delegate?.buttonDidTap(textField3.text!, sender: self)
        delegate?.buttonDidTap(textField4.text!, sender: self)
        delegate?.buttonDidTap(textField5.text!, sender: self)
        delegate?.buttonDidTap(textField6.text!, sender: self)
    }

}
protocol CustomViewDelegate: class {
    func buttonDidTap(text: String, sender: FreeRegistrationView)
}