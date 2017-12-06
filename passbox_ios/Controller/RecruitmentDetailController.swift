//募集詳細
import UIKit

class RecruitmentDetailController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shippingView: UIView!
    
    @IBOutlet weak var buttonView: UIView!
    
    var orderId: [Int] = []
    var recruitmentDetails:[RecruitmentDetail] = [RecruitmentDetail]()
    private var proposalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFriends()
        
        tableView.delegate = self
        tableView.dataSource = self

        var nib = UINib(nibName: "RecruitmentDetailView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        shippingView = RecruitmentDetailShippingView.instance()
        shippingView.frame = CGRectMake(0, self.view.frame.size.height - 400, self.view.frame.size.width, 1500)
        
        self.view.addSubview(shippingView)
        
        //最前面
        self.proposalPushButton()
//        self.view.bringSubviewToFront(buttonView)
//        self.view.sendSubviewToBack(shippingView)
        
    }
    @IBAction func backButton(sender: UIButton) {
        //一つ前の画面へ遷移
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func proposalPushButton() {
        // Buttonを生成する.
        proposalButton = UIButton()
        // サイズを設定する.
        proposalButton.frame = CGRectMake(0,0,298,39)
        // 背景色を設定する.
        proposalButton.backgroundColor = UIColor.hex("66CDCC", alpha: 1)
        // 枠を丸くする.
        proposalButton.layer.masksToBounds = false
        // タイトルを設定する(通常時).
        proposalButton.setTitle("提案する", forState: UIControlState.Normal)
        proposalButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // コーナーの半径を設定する.
        proposalButton.layer.cornerRadius = 3.0
        // ボタンの位置を指定する.
        proposalButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 50)
        // タグを設定する.
        proposalButton.tag = 1
        // イベントを追加する.
        proposalButton.addTarget(self, action: "onClickProposalButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(proposalButton)
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
    
    //提案するボタン押下
    internal func onClickProposalButton(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("ProposalController") as! UIViewController
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
