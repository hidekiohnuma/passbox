//募集詳細
import UIKit

class BaggageOrderStatusView: UITableViewCell {
    
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
    
    func setCell(baggageOrderStatus :BaggageOrderStatus) {
        self.label1.text = baggageOrderStatus.label1
        self.label2.text = baggageOrderStatus.label2
        self.label2_2.text = baggageOrderStatus.label2_2
        self.label3.text = baggageOrderStatus.label3
        self.label4.text = baggageOrderStatus.label4
        self.label5.text = baggageOrderStatus.label5
        self.label6.text = baggageOrderStatus.label6
        self.imageName.image = UIImage(named: baggageOrderStatus.imageName as String)
    }
}
