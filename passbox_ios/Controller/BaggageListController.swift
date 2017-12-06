import UIKit

import CoreLocation

class BaggegeListController: UIViewController, UITableViewDelegate ,UITableViewDataSource, CLLocationManagerDelegate  {
    
    @IBOutlet var table: UITableView!
    
    var nowlocationManager: CLLocationManager!
    
    //7項目
    var orderId: [Int] = []
    var orderProjectTitle: [String] = []
    var consultationContent: [String] = []
    var orderUserName: [String] = []
    var orderStart: [String] = []
    var orderLoadDate: [String] = []
    var orderDestination: [String] = []
    var orderUnloadDate: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "荷物選択"
        // インジケータ on
        SVProgressHUD.show()
        
        makeTableData()
        
        nowlocationManager = CLLocationManager()
        nowlocationManager.delegate = self
        nowlocationManager.desiredAccuracy = kCLLocationAccuracyBest
        nowlocationManager.distanceFilter = 100
        
        // 位置情報取得の許可状況を確認
        let status = CLLocationManager.authorizationStatus()
        
        // 許可が必要な場合は確認ダイアログを表示
        if(status == CLAuthorizationStatus.NotDetermined) {
            print("didChangeAuthorizationStatus:\(status)");
            self.nowlocationManager.requestAlwaysAuthorization()
        }
        
        self.nowlocationManager.startUpdatingLocation()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let loginId: String = defaults.objectForKey("Key01") as! String
        
        let manager = AFHTTPRequestOperationManager()
        var param = ["email" : loginId]
        
        manager.POST("http://153.126.185.130:8080/api/v1/users/user_name?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                let accountName = responseObject["response"]!!["sender_infos"]!![0]["name"]!
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.accountData = accountName! as! String
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
    }
    override func viewDidAppear(animated: Bool) {
        
        UIApplication.sharedApplication(
            ).networkActivityIndicatorVisible = false
        
        // インジケータ off
        SVProgressHUD.dismiss()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "荷物一覧"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    //Table Viewのセルの数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderId.count
    }
    
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
     
        //7項目
        let label1 = table.viewWithTag(1) as! UILabel
        label1.text = "\(orderProjectTitle[indexPath.row])"
        
        let label2 = table.viewWithTag(2) as! UILabel
        label2.text = "\(consultationContent[indexPath.row])"
        //orderstart
        let label3 = table.viewWithTag(3) as! UILabel
        label3.text = "\(orderUserName[indexPath.row])"
        
        let label4 = table.viewWithTag(4) as! UILabel
        label4.text = "\(orderStart[indexPath.row] ?? NSNull())"
        
        let label5 = table.viewWithTag(5) as! UILabel
        label5.text = "\(orderLoadDate[indexPath.row])"
        
        let label6 = table.viewWithTag(6) as! UILabel
        label6.text = "\(orderDestination[indexPath.row])"
        
        let label7 = table.viewWithTag(7) as! UILabel
        label7.text = "\(orderUnloadDate[indexPath.row])"
        
        let labelId = "\(orderId[indexPath.row])"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let labelId = "\(orderId[indexPath.row])"
        var stringId = String(labelId)
        print(labelId)
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.sendData = stringId
        
        
        //次画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("TransitionController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)

    }
    
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        
        var lat = manager.location!.coordinate.latitude
        var log = manager.location!.coordinate.longitude
        getApi(lat,log: log)
        
    }
    
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError){
        
        print("locationManager error", terminator: "")
        
    }
    
    func getApi(lat: Double,log: Double){
        
        let manager = AFHTTPRequestOperationManager()
        var param:Dictionary<String, Double> = ["lat" : lat, "lon" : log]
        
        manager.POST("http://153.126.185.130:8080/api/v1/address_create?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                let defaults = NSUserDefaults.standardUserDefaults()
                let address01 = responseObject["response"]!!["address"]
                
                defaults.setObject(address01!!, forKey: "nowaddress01")
                defaults.setObject(lat, forKey: "nowLat")
                defaults.setObject(log, forKey: "nowLog")
                
                let successful = defaults.synchronize()
                if successful {
                    print("データの保存に成功しました。")
                }
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
    }
    func makeTableData() {
        // 荷物一覧API
        let defaults = NSUserDefaults.standardUserDefaults()
        var UserId: Int = defaults.objectForKey("UserId") as! Int

        let manager = AFHTTPRequestOperationManager()
        var param = ["user_id" : UserId]

        manager.POST("http://153.126.185.130:8080/api/v1/orders/list?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                let orderList = responseObject["response"]!!["order_lists"]
                let orderListCount = responseObject["response"]!!["order_lists"]
                var count = orderListCount!!.count
                
                for i in 0..<count{
                    //7項目
                    let orderId = responseObject["response"]!!["order_lists"]!![i]["id"]!//id
                    let orderProjectTitle = responseObject["response"]!!["order_lists"]!![i]["project_title"]!//依頼title
                    let consultationContent = responseObject["response"]!!["order_lists"]!![i]["consultation_content"]!//依頼内容
                    let orderUserName = responseObject["response"]!!["order_lists"]!![i]["order_user_name"]!// 依頼主
                    let orderStart = responseObject["response"]!!["order_lists"]!![i]["start"]!// 積み込みエリア
                    let orderLoadDate = responseObject["response"]!!["order_lists"]!![i]["load_date"]!// 積み込み日時
                    let orderDestination = responseObject["response"]!!["order_lists"]!![i]["destination"]!//荷降ろしエリア
                    let orderUnloadDate = responseObject["response"]!!["order_lists"]!![i]["unload_date"]!//荷降ろし日時
                    
                    self.orderId.append(orderId! as! Int)
                    //nullだった場合の処理
                    if(orderProjectTitle?.isKindOfClass(NSNull) == true){
                        let orderProjectTitle = "データがありません"
                        self.orderProjectTitle.append(orderProjectTitle as! String )
                        
                    }else{
                        self.orderProjectTitle.append(orderProjectTitle! as! String )
                    }
                    if(consultationContent?.isKindOfClass(NSNull) == true){
                        let consultationContent = "データがありません"
                        self.consultationContent.append(consultationContent as! String )
                        
                    }else{
                        self.consultationContent.append(consultationContent! as! String )
                    }
                    if(orderUserName?.isKindOfClass(NSNull) == true){
                        let orderUserName = "データがありません"
                        self.orderUserName.append(orderUserName as! String )
                        
                    }else{
                        self.orderUserName.append(orderUserName! as! String )
                    }
                    if(orderStart?.isKindOfClass(NSNull) == true){
                        let orderStart = "データがありません"
                        self.orderStart.append(orderStart as! String )
                        
                    }else{
                        self.orderStart.append(orderStart! as! String )
                    }
                    if(orderLoadDate?.isKindOfClass(NSNull) == true){
                        let orderLoadDate = "データがありません"
                        self.orderLoadDate.append(orderLoadDate as! String )
                        
                    }else{
                        self.orderLoadDate.append(orderLoadDate! as! String )
                    }
                    
                    if(orderDestination?.isKindOfClass(NSNull) == true){
                        let orderDestination = "データがありません"
                        self.orderDestination.append(orderDestination as! String )
                        
                    }else{
                        self.orderDestination.append(orderDestination! as! String )
                    }
                    
                    if(orderUnloadDate?.isKindOfClass(NSNull) == true){
                        let orderUnloadDate = "データがありません"
                        self.orderUnloadDate.append(orderUnloadDate as! String )
                        
                    }else{
                        self.orderUnloadDate.append(orderUnloadDate! as! String )
                    }
                    
                }
                
                // tableをリロードしてデータ取得
                self.table.reloadData()
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}