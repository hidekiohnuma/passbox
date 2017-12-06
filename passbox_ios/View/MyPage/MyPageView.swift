import UIKit

class MyPageView: UIView {
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    weak var delegate: MyPageViewDelegate! = nil
    
    override func awakeFromNib() {
        // XIB読み込み
        let view = NSBundle.mainBundle().loadNibNamed("MyPageView", owner: self, options: nil).first as! UIView
        addSubview(view)
        
        getApi()
        
        
    }
    //編集するテキストリンク
    @IBAction func editButton(sender: UIButton) {
        //SelfIntroductionController
        delegate?.editButtonDidTap("自己紹介編集", sender: self)
        
    }
    //受取口座テキストリンク
    @IBAction func receivingAccountButton(sender: UIButton) {
        //AccountRegistrationController
        delegate?.receivingAccountButtonDidTap("口座", sender: self)
        
    }
    //決済履歴テキストリンク
    @IBAction func settlementHistoryButton(sender: UIButton) {
        //SettlementHistoryListController
        delegate?.settlementHistoryButtonDidTap("決済履歴", sender: self)
    }
    func getApi(){
//        let loginId: String = defaults.objectForKey("Key01") as! String
        let loginId: String = "test@test.jp"
        let manager = AFHTTPRequestOperationManager()
        var param = ["email" : loginId]
        
        manager.POST("http://153.126.185.130:8080/api/v1/users/user_name?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                let userName = responseObject["response"]!!["sender_infos"]!![0]["user_name"]!
                let companyName = responseObject["response"]!!["sender_infos"]!![0]["company_name"]!
                let introduction = responseObject["response"]!!["sender_infos"]!![0]["self_introduction"]!
                let userImage = responseObject["response"]!!["sender_infos"]!![0]["user_image"]!
                let mail = responseObject["response"]!!["sender_infos"]!![0]["mail"]!
                let phoneNumber = responseObject["response"]!!["sender_infos"]!![0]["phone_number"]!
                
                self.title1.text = userName! as! String
                self.title2.text = companyName! as! String
                self.title3.text = introduction! as! String
                self.mail.text = mail! as! String
                self.phoneNumber.text = phoneNumber! as! String
                
                //画像指定
                let url = NSURL(string: userImage! as! String);
                let imgData: NSData
                
                do {
                    imgData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    self.imageView.image = UIImage(data:imgData)
                } catch {
                    print("Error: can't create image.")
                }
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
    }
    
}
protocol MyPageViewDelegate: class {
    func editButtonDidTap(text: String, sender: MyPageView)
    func receivingAccountButtonDidTap(text: String, sender: MyPageView)
    func settlementHistoryButtonDidTap(text: String, sender: MyPageView)
}