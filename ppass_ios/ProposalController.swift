import Foundation
import UIKit

class ProposalController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var proposalCustomView: ProposalView!
    @IBOutlet weak var tableView: UITableView!
    
    var orderId: [Int] = []
    var recruitmentDetails:[RecruitmentDetail] = [RecruitmentDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFriends()
        tableView.delegate = self
        tableView.dataSource = self
        proposalCustomView.delegate = self
        
        var nib = UINib(nibName: "RecruitmentDetailView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        
     
//        let proposalView = ProposalView.instance()
//        proposalView.frame = self.view.frame
//        self.view.addSubview(proposalView)
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
                
//                for i in 0..<count{
                    let orderId = responseObject["response"]!!["order_lists"]!![0]["id"]!//id
                    let projectTitle = responseObject["response"]!!["order_lists"]!![0]["project_title"]!
                    let start = responseObject["response"]!!["order_lists"]!![0]["start"]!
                    let destination = responseObject["response"]!!["order_lists"]!![0]["destination"]!
                    let loadDate = responseObject["response"]!!["order_lists"]!![0]["load_date"]!
                    let baggageType = responseObject["response"]!!["order_lists"]!![0]["baggage_type"]!
                    let orderUserName = responseObject["response"]!!["order_lists"]!![0]["order_user_name"]!
                    let budgetUpper = responseObject["response"]!!["order_lists"]!![0]["budget_upper"]!!.description
                    let img = responseObject["response"]!!["order_lists"]!![0]["order_user_image"]!
                    
                    var value = RecruitmentDetail(label1: projectTitle as? String, label2:start as? String,label2_2:destination as? String,label3:loadDate as? String,label4:baggageType as? String,label5:orderUserName as? String,label6:budgetUpper as? String,imageName:(img as? String)!)
                    self.recruitmentDetails.append(value)
                    self.orderId.append(orderId! as! Int)
//                }
                // tableをリロードしてデータ取得
                self.tableView.reloadData()
                
            
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return recruitmentDetails.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? RecruitmentDetailView
        
        //cell中身セット（引数　セル、indexPath）
        cell?.setCell(recruitmentDetails[indexPath.row])
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
extension ProposalController: ProposalViewDelegate {
    func buttonDidTap(text: String, sender: ProposalView) {
        //api処理
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("ProposalCompleteController") as! UIViewController
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
}
