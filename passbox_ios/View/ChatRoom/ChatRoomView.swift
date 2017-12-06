import UIKit

class ChatRoomView: UITableViewCell {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var imageName: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(chatroom :ChatRoom) {
        self.label1.text = chatroom.label1
        self.label2.text = chatroom.label2
        self.label3.text = chatroom.label3
        self.imageName.image = UIImage(named: chatroom.imageName as String)
    }
}
