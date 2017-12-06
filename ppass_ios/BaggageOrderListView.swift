import UIKit

class BaggageOrderListView: UITableViewCell {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label2_2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var imageName: UIImageView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(baggageOrderList :BaggageOrderList) {
        self.label1.text = baggageOrderList.label1
        self.label2.text = baggageOrderList.label2
        self.label2_2.text = baggageOrderList.label2_2
        self.label3.text = baggageOrderList.label3
        self.label4.text = baggageOrderList.label4
        self.label5.text = baggageOrderList.label5
        self.label6.text = baggageOrderList.label6
        self.imageName.image = UIImage(named: baggageOrderList.imageName as String)
    }
}
