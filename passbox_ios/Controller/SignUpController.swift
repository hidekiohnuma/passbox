import UIKit

class SignUpController: UIViewController, UITextFieldDelegate {
    
    
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
        
        var name = "会員登録"
        
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
    
    @IBAction func TouchSignUpButton(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.FreeRegistrationId = loginId.text
        appDelegate.FreeRegistrationPassword = loginPassword.text
        
        
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("SignUpDetailController") as! UIViewController
        
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