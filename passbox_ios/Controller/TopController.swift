import UIKit

import CoreLocation

class TopController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet var loginButton: UIButton!
    var nowlocationManager: CLLocationManager!
    
    let ApplicationDidFinishLaunchingNotification = "ApplicationDidFinishLaunchingNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 30分毎に実行
//        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "reLogin", userInfo: nil, repeats: true)
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
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationDidFinishLaunching:",
            name: ApplicationDidFinishLaunchingNotification,
            object: nil
        )
    
    }
    func applicationDidFinishLaunching(notification: NSNotification) {
        print("applicationDidFinishLaunching!")
    }
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        
        var lat = manager.location!.coordinate.latitude
        var log = manager.location!.coordinate.longitude
        getApi(lat,log: log)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "トップ"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func TouchLoginButton(sender: AnyObject) {
        
        // 遷移先
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 生成
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if((defaults.objectForKey("Key01")) != nil){

            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("MySidePanelControllerViewController") as! UIViewController
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // View移動
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
        } else {

            let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("LoginActionController") as! UIViewController
            mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            // View移動
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
        }
        
    }
    @IBAction func TouchSignUpButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("SignUpController") as! UIViewController
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // View移動
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
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
                
                var sendOrderId = "packageId"
                //座標を送信
                let userLat = lat
                let userLong = log
                
                //現在時間取得
                let now = NSDate()
                let formatter = NSDateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let createdAt = formatter.stringFromDate(now)
                
                // 運送状況の位置情報送信　order_id　latitude　longitude　created_at
                let manager = AFHTTPRequestOperationManager()
                let param = ["order_id" : sendOrderId,"latitude" : userLat,"longitude":userLong,"created_at":createdAt]
                
                manager.POST("http://153.126.185.130:8080/api/v1/location_infos?", parameters: param,
                    success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                        
                        print(responseObject["common"])
                        
                    }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                        
                        print("Error: \(error)")
                        
                })
                
                let successful = defaults.synchronize()
                if successful {
                    print("データのfirst保存に成功しました。")
                }
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
    }
    
//    func reLogin(){
//        // 生成
//        let defaults = NSUserDefaults.standardUserDefaults()
//        
//        if(defaults.objectForKey("Key01") as! String != ""){
//          defaults.removeObjectForKey("Key01")
//          defaults.removeObjectForKey("Key02")
//        }
//        // 画面遷移
//        let mySecondViewController = storyboard!.instantiateViewControllerWithIdentifier("LoginActionController") as! UIViewController
//        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
//        
//        // View移動
//        self.presentViewController(mySecondViewController, animated: true, completion: nil)
//    }
    
}