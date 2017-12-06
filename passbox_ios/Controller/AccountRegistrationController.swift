import Foundation
import UIKit

class AccountRegistrationController: UIViewController,UITabBarDelegate,UINavigationBarDelegate  {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var accountCustomView: AccountRegistrationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountCustomView.delegate = self
        headerView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
//データ送信API
extension AccountRegistrationController: AccountCustomSendValueDelegate {
    func sendValue(text1: String,text2: String,text3: String,sender: AccountRegistrationView){
        let defaults = NSUserDefaults.standardUserDefaults()
        // var UserId: Int = defaults.objectForKey("UserId") as! Int
        // 仮設定
        var UserId: Int = 1
        //api処理
        let manager = AFHTTPRequestOperationManager()
        let param = ["user_id" : UserId,"bank_name" : text1,"branch_bank_number": text2,"account_number": text3]
        manager.POST("http://153.126.185.130:8080/api/v1/users/2/receive_accounts?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                print(responseObject["common"])
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                
                print("Error: \(error)")
                
        })
    }

}