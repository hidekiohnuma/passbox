import UIKit

class RecruitmentListController: UIViewController, UITableViewDelegate ,UITableViewDataSource, UITabBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var orderId: [Int] = []
    var Recruitments:[Recruitment] = [Recruitment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFriends()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var nib = UINib(nibName: "RecruitmentView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        
        
        let footerView = FooterView.instance()
        footerView.delegate = self
        footerView.frame = CGRectMake(0, self.view.frame.size.height - 52, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(footerView)
    }
    
    //push searchButton
    @IBAction func searchButton(sender: UIButton) {
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("SearchController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    //push settingButton
    @IBAction func settingButton(sender: UIButton) {
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("SearchController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
    
    func setupFriends() {
        // api取得
//        var UserId = 2
        let manager = AFHTTPRequestOperationManager()
//        var param = ["user_id" : UserId]
        
        manager.GET("http://153.126.185.130:8080/api/v1/orders",parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                let orderListCount = responseObject["response"]!!["order_lists"]
                var count = orderListCount!!.count
                
                for i in 0..<count{
                    let orderId = responseObject["response"]!!["order_lists"]!![i]["id"]!//id
                    let projectTitle = responseObject["response"]!!["order_lists"]!![i]["project_title"]!
                    let start = responseObject["response"]!!["order_lists"]!![i]["start"]!
                    let destination = responseObject["response"]!!["order_lists"]!![i]["destination"]!
                    let loadDate = responseObject["response"]!!["order_lists"]!![i]["load_date"]!
                    let baggageType = responseObject["response"]!!["order_lists"]!![i]["baggage_type"]!
                    let orderUserName = responseObject["response"]!!["order_lists"]!![i]["order_user_name"]!
                    let budgetUpper = responseObject["response"]!!["order_lists"]!![i]["budget_upper"]!!.description
                    let img = responseObject["response"]!!["order_lists"]!![i]["order_user_image"]!
                    
                    var i = Recruitment(label1: projectTitle as? String, label2:start as? String,label2_2:destination as? String,label3:loadDate as? String,label4:baggageType as? String,label5:orderUserName as? String,label6:budgetUpper as? String,imageName:(img as? String)!)
                    self.Recruitments.append(i)
                    self.orderId.append(orderId! as! Int)
                }
                
                // tableをリロードしてデータ取得
                self.tableView.reloadData()
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return Recruitments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? RecruitmentView
        
        //cell中身セット（引数　セル、indexPath）
        cell?.setCell(Recruitments[indexPath.row])
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let labelId = "\(orderId[indexPath.row])"
        
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("RecruitmentDetailController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        
        
        
        
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
