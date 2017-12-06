import UIKit

class LoginActionController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var loginId: UITextField!
    @IBOutlet weak var loginPassword: UITextField!

    private var loginbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginId.delegate = self
        self.loginPassword.delegate = self
        self.loginPassword.secureTextEntry = true
        
        // 30分毎に実行
        NSTimer.scheduledTimerWithTimeInterval(180, target: self, selector: "reLogin", userInfo: nil, repeats: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "ログイン"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.loginId {
            print("loginId")
        } else {
            print("loginPassword")
        }
        
        // テキストの入力内容をコンソール表示
        print(textField.text)
        // キーボードを非表示
        self.view.endEditing(true)
        
        return false
    }
    
    @IBAction func TouchLoginButton(sender: AnyObject) {
        let inputLoginId = loginId.text
        let inputLoginPassword = loginPassword.text
        
        let manager = AFHTTPRequestOperationManager()
        var param:Dictionary<String, String> = ["email" : inputLoginId!, "password" : inputLoginPassword!]
        manager.POST("http://153.126.185.130:8080/api/v1/users/auth?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                print("response: \(responseObject)")
                let setUserId = responseObject["response"]!!["sender_infos"]!![0]["user_id"]!
                
                //userDefault保存
                // 生成
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setObject(inputLoginId, forKey: "Key01")
                defaults.setObject(inputLoginPassword, forKey: "Key02")
                defaults.setObject(setUserId, forKey: "UserId")
                
                let successful = defaults.synchronize()
                if successful {
                    print("データの保存に成功しました。")
                }
                
                //次画面遷移
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("MySidePanelControllerViewController") as! UIViewController
                
                // アニメーションを設定する.
                mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                
                // Viewの移動する.
                self.presentViewController(mySecondViewController, animated: true, completion: nil)
                
                self.loginId.text = nil
                self.loginPassword.text = nil
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
                //alertView表示
                self.alertView(self)
        })
    }
    @IBAction func alertView(sender : AnyObject){
        let alert = UIAlertView()
        alert.title = "入力項目に間違いがあります"
        alert.message = "再度入力し直してください"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    func reLogin(){
        // 生成
        let defaults = NSUserDefaults.standardUserDefaults()
        let Key01: String = defaults.objectForKey("Key01") as! String
        let Key02: String = defaults.objectForKey("Key02") as! String
        let UserId: String = defaults.objectForKey("UserId") as! String
        
        if(Key01 != ""){
            defaults.removeObjectForKey("Key01")
            defaults.removeObjectForKey("Key02")
            defaults.removeObjectForKey("UserId")
        }
    }
    @IBAction func tems(sender : UIButton){
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("BeforeTermsController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        
    }
    @IBAction func privacy(sender : UIButton){
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("BeforePrivacyController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)

    }
    @IBAction func forgetPassword(sender : UIButton){
        var inputTextField: UITextField?
        let alertController: UIAlertController = UIAlertController(title: "Email", message: "Emailを入力してください", preferredStyle: .Alert)
        let otherAction: UIAlertAction = UIAlertAction(title: "送信", style: .Default) { action -> Void in
            print("Pushed 送信")
            // 未入力時
            if(inputTextField?.text != "" ){
                print(inputTextField?.text)
                //仕様検討のためAPI処理は保留
                
            }else{
                self.alertView(self)
            }
        }
        alertController.addAction(otherAction)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel) { action -> Void in
            print("Pushed CANCEL")
        }
        alertController.addAction(cancelAction)
        
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            inputTextField = textField
            textField.placeholder = "Enter an Email"
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}