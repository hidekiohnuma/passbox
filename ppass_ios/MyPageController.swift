//mypage
import Foundation
import UIKit

class MyPageController: UIViewController, UITabBarDelegate,UINavigationBarDelegate {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var mypageCustomView: MyPageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mypageCustomView.delegate = self
        headerView.delegate = self
        
        let footerView = FooterView.instance()
        footerView.delegate = self
        footerView.frame = CGRectMake(0, self.view.frame.size.height - 52, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(footerView)
    }
    
    //footer tabbar遷移
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        switch item.tag {
        case 1:
            //荷物依頼画面遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("BaggageListController") as! UIViewController
            // アニメーションを設定する.
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // Viewの移動する.
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
        case 2:
            //空き登録画面遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("FreeRegistrationController") as! UIViewController
            // アニメーションを設定する.
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // Viewの移動する.
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
            
        case 3:
            //マイボックス画面遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("ReceivedMessageController") as! UIViewController
            // アニメーションを設定する.
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // Viewの移動する.
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
        case 4:
            //チャット一覧画面遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("ChatRoomController") as! UIViewController
            // アニメーションを設定する.
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // Viewの移動する.
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
        case 5:
            //マイページ画面遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("MyPageController") as! UIViewController
            // アニメーションを設定する.
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // Viewの移動する.
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
            
        default:
            print("else")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
extension MyPageController: HeaderViewDelegate {
    func setTitle(text: String, sender:HeaderView){
        print(text)
    }
}
extension MyPageController: MyPageViewDelegate {
    func editButtonDidTap(text: String, sender: MyPageView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("SelfIntroductionController") as! UIViewController
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        
        
    }
    func receivingAccountButtonDidTap(text: String, sender: MyPageView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("AccountRegistrationController") as! UIViewController
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        
    }
    func settlementHistoryButtonDidTap(text: String, sender: MyPageView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("SettlementHistoryListController") as! UIViewController
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
}