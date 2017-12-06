import UIKit

class HeaderView: UINavigationBar,UINavigationBarDelegate {
    
//    @IBOutlet weak var headerTitle: UILabel?
    @IBOutlet weak var headerTitle: UINavigationItem!
    weak var headerdelegate: HeaderViewDelegate! = nil
//    weak var delegate: HeaderViewDelegate! = nil
//    class func instance() -> HeaderView{
//        
//        return UINib(nibName: "HeaderView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! HeaderView
//    }
    override func awakeFromNib() {
        // XIB読み込み
        let view = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil).first as! UIView
        addSubview(view)
        
        headerdelegate?.setTitle("空き登録", sender: self)
    }
    
}
protocol HeaderViewDelegate: class {
    func setTitle(text: String, sender:HeaderView)
}