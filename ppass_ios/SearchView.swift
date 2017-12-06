import UIKit

class SearchView: UIView,UIPickerViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    var areaOption = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    var baggageOption = ["農産物","畜産物","水産物","食料品","飲料品","木材","砂利・砂等","金属製品","鋼材","建材","電気製品","機械・装置","セメント","セメント製品","紙・パルプ製品","石油製品","化学製品","その他危険物","衣料・雑貨","引越し","その他"]
    var pickOption = ["平型", "バン型", "ウィング型", "保冷車", "冷凍車","車載車","重機運搬車","危険物運搬車","ダンプ","幌","ユニック","海上コンテナ","その他","希望無し"]
    
    
    weak var delegate: SearchViewDelegate! = nil
    
    override func awakeFromNib() {
        // XIB読み込み
        let view = NSBundle.mainBundle().loadNibNamed("SearchView", owner: self, options: nil).first as! UIView
        addSubview(view)
        let selectPicker1 = UIPickerView()
        let selectPicker2 = UIPickerView()
        let selectPicker3 = UIPickerView()
        let selectPicker4 = UIPickerView()
        
        selectPicker1.delegate = self
        selectPicker2.delegate = self
        selectPicker3.delegate = self
        selectPicker4.delegate = self
        selectPicker1.tag = 1
        selectPicker2.tag = 2
        selectPicker3.tag = 3
        selectPicker4.tag = 4
        
        self.textField1.delegate = self
        self.textField2.delegate = self
        self.textField3.delegate = self
        self.textField4.delegate = self
        
        textField1.inputView = selectPicker1
        textField2.inputView = selectPicker2
        textField3.inputView = selectPicker3
        textField4.inputView = selectPicker4
        
        
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowsNumber:Int = 0
        if (pickerView.tag == 1 || pickerView.tag == 2) {
            rowsNumber = areaOption.count
        }
        if (pickerView.tag == 3){
            rowsNumber = baggageOption.count
        }
        if (pickerView.tag == 4){
            rowsNumber = pickOption.count
        }
        return rowsNumber
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var picComponent:String = ""
        if (pickerView.tag == 1 || pickerView.tag == 2) {
            picComponent = areaOption[row]
        }
        if (pickerView.tag == 3){
            picComponent = baggageOption[row]
        }
        if (pickerView.tag == 4){
            picComponent = pickOption[row]
        }
        return picComponent
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            textField1.text = areaOption[row]
        }
        if(pickerView.tag == 2){
            textField2.text = areaOption[row]
        }
        if(pickerView.tag == 3){
            textField3.text = baggageOption[row]
        }
        if(pickerView.tag == 4){
            textField4.text = pickOption[row]
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
//        return false
        
    }
    
    @IBAction func searchButton(sender: UIButton) {
        delegate?.searchButton(textField1.text!, sender: self)
        delegate?.searchButton(textField2.text!, sender: self)
        delegate?.searchButton(textField3.text!, sender: self)
        delegate?.searchButton(textField4.text!, sender: self)
    }
    
}
protocol SearchViewDelegate: class {
    func searchButton(text: String, sender: SearchView)
}