import UIKit

class CompletedController: UIViewController{
    
    @IBOutlet var CompletedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "運送完了"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "運送完了"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    @IBAction func TouchCompletedButton(sender: AnyObject) {
        // 遷移先  
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("MySidePanelControllerViewController") as! UIViewController
        
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // View移動
        self.presentViewController(mySecondViewController, animated: true, completion: nil)        
    }
}