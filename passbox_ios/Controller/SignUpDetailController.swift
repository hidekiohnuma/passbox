import UIKit

class SignUpDetailController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var loginName: UITextField!
    @IBOutlet weak var loginCompanyName: UITextField!
    @IBOutlet weak var loginTelNum: UITextField!
    
    private var loginbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginName.delegate = self
        self.loginCompanyName.delegate = self
        self.loginTelNum.delegate = self
        
        // 30分毎に実行
        NSTimer.scheduledTimerWithTimeInterval(180, target: self, selector: "reLogin", userInfo: nil, repeats: true)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "会員登録詳細"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // テキストの入力内容をコンソール表示
        print(textField.text)
        // キーボードを非表示
        self.view.endEditing(true)
        
        return false
    }
    
    @IBAction func TouchSignUpDetailButton(sender: AnyObject) {
        //delegeteでID.passデータ取得
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var sendFreeRegistrationId = appDelegate.FreeRegistrationId
        var sendFreeRegistrationPassword = appDelegate.FreeRegistrationPassword
        
        var inputLoginName = loginName.text
        var inputLoginCompanyName = loginCompanyName.text
        var inputLoginTelNum = loginTelNum.text
        
        // api送信
        // 会員登録情報送信
        let manager = AFHTTPRequestOperationManager()
        let param = ["freeregistration_id" : sendFreeRegistrationId!,"freeregistration_password" : sendFreeRegistrationPassword!,"login_name":inputLoginName!,"login_companyname":inputLoginCompanyName!,"login_telnum":inputLoginTelNum!]
        
        manager.POST("http://153.126.185.130:8080/api/v1/users?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                print(responseObject["common"])
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                
                print("Error: \(error)")
                
        })
        
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("FreeRegistrationController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    @IBAction func alertView(sender : AnyObject){
        let alert = UIAlertView()
        alert.title = "入力項目に間違いがあります"
        alert.message = "再度入力し直してください"
        alert.addButtonWithTitle("OK")
        alert.show()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}