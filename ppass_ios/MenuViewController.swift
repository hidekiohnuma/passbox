//
//  MenuViewController.swift
//  JASidePanels_Menu_Sample
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource  {
    
    var menus:[String]=[];
    var accountName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menus = ["テスト名前","荷物選択","お問い合わせ", "利用規約", "プライバシーポリシー","ログアウト"]
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var accountName = appDelegate.accountData
        
//        let Key03: String = defaults.objectForKey("Key03") as! String
        menus[0] = accountName!;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = menus[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
//            self.sidePanelController!.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("MapController"))! as UIViewController
            break
        case 1:
            self.sidePanelController!.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("BaggegeListController"))! as UIViewController
            break
        case 2:
            self.sidePanelController!.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("ContactController"))! as UIViewController
            break
        case 3:
            self.sidePanelController!.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("TermController"))! as UIViewController
            break
        case 4:
            self.sidePanelController!.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("PrivacyController"))! as UIViewController
            break
        case 5:
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.removeObjectForKey("Key01")
            defaults.removeObjectForKey("Key02")
            defaults.removeObjectForKey("UserId")
//            defaults.removeObjectForKey("Key03")
            defaults.removeObjectForKey("acountName")
            
            print("データの削除に成功しました。")
            
            //ログイン画面へ遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("LoginActionController") as! UIViewController
            
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // View移動
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }
}
