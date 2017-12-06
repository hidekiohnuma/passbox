import UIKit

class SettlementHistoryListController: UIViewController, UITableViewDelegate ,UITableViewDataSource, UITabBarDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var orderId: [Int] = []
    var Settlements:[Settlement] = [Settlement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFriends()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var nib = UINib(nibName: "SettlementHistoryListView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
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
                    
                    var i = Settlement(label1: projectTitle as? String, label2:start as? String)
                    self.Settlements.append(i)
                    self.orderId.append(orderId! as! Int)
                }
                
                // tableをリロードしてデータ取得
                self.tableView.reloadData()
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return Settlements.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? SettlementHistoryListView
        
        //cell中身セット（引数　セル、indexPath）
        cell?.setCell(Settlements[indexPath.row])
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let labelId = "\(orderId[indexPath.row])"
        
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("SettlementHistoryDetailController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
