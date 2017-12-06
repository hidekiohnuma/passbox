import UIKit

//UITabBarControllerを継承
class MainTabBarController: UITabBarController {
//    var firstView: FirstViewController!
//    var secondView: SecondViewController!
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstView = FreeRegistrationController()
        let secondView = MyPageController()
        
        //表示するtabItemを指定（今回はデフォルトのItemを使用）
        firstView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Featured, tag: 1)
        secondView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 2)
        
        // タブで表示するViewControllerを配列に格納します。
        let myTabs = NSArray(objects: firstView, secondView)
        
        // 配列をTabにセットします。
        self.setViewControllers(myTabs as? [UIViewController], animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}