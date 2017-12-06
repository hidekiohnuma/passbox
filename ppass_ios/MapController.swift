//
// author pass
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController,NSURLSessionDelegate,NSURLSessionDataDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var goalText: UITextField!
    @IBOutlet weak var resultbutton: UIButton!
    
    private var myButton: UIButton!
    private var stopButton: UIButton!
    private var finishButton: UIButton!
    private var nowpositionButton: UIButton!
    var locationManager: CLLocationManager!
    var nowlocationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D!
    var destLocation: CLLocationCoordinate2D!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var maker_icon_g: UIImageView!
    @IBOutlet weak var maker_icon: UIImageView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "荷物選択"
        
        self.startText.delegate = self
        self.goalText.delegate = self
        
        //地図
        locationManager = CLLocationManager()
        locationManager.delegate = self
        mapView.delegate = self
        
        //位置情報の精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //位置情報取得間隔(m)
        locationManager.distanceFilter = 100

        
        //startText enable false
        self.startText.enabled = false
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let nowaddress01: String = defaults.objectForKey("nowaddress01") as! String
        //nowLat nowLot
        let nowLat: Double = defaults.objectForKey("nowLat") as! Double
        let nowLot: Double = defaults.objectForKey("nowLog") as! Double
      
        self.startText.text = "現在地:" + nowaddress01
        //placeholder
        self.goalText.placeholder = "目的地を入力する"
        
        // goalText入力されたらボタン表示
        self.resultbutton.hidden = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "マップ"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    
    // キーボードを非表示
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        // goalText入力されたらボタン表示
        if(goalText.text != ""){
            self.resultbutton.hidden = false
        }
        return false
    }
    
    //ルート決定ボタン
    @IBAction func TouchResutlButton(sender: AnyObject) {
        // 現在地ボタン表示
        nowpositionbutton()
        
        self.resultbutton.hidden = true
        let inputGoalText = goalText.text
        
        //開始するボタン表示
        startbutton()
        
        // セット済みのピンを削除
        self.mapView.removeAnnotations(self.mapView.annotations)
        // キーボードを隠す
        goalText.resignFirstResponder()
        // 描画済みの経路を削除
        self.mapView.removeOverlays(self.mapView.overlays)
        
        mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: false)
        // 目的地の文字列から座標検索
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(inputGoalText!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            var placemark: CLPlacemark!
            for placemark in placemarks! {
                print("Name: \(placemark.name)")
                print("Locality: \(placemark.locality)")
                print("PostalCode: \(placemark.postalCode)")
                print("areaOfInterest: \(placemark.areasOfInterest)")
                print("Ocean: \(placemark.ocean)")
                print("Administrative Area = \(placemark.administrativeArea)")
                print("Sub Administrative Area = \(placemark.subAdministrativeArea)")
                print("Locality = \(placemark.locality)")
                print("Sub Locality = \(placemark.subLocality)")
                print("Throughfare = \(placemark.thoroughfare)")
                
                self.destLocation = CLLocationCoordinate2DMake(placemark.location!.coordinate.latitude, placemark.location!.coordinate.longitude)
                self.locationManager.startUpdatingLocation()
                
                //userDefault保存
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(inputGoalText, forKey: "goal01")
                
                let successful = defaults.synchronize()
                if successful {
                    print("データの保存に成功しました。")
                }
            }
        })
    }
    
    //現在地ボタン
    func nowpositionbutton() {
        // Buttonを生成する.
        nowpositionButton = UIButton(frame: CGRectMake(self.view.frame.width/2 + 100, 300, 50, 50));
        var buttonImage:UIImage = UIImage(named: "map_circle_icon@2x.png")!;
        nowpositionButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal);
        nowpositionButton.addTarget(self, action: "now_btn_click:", forControlEvents:.TouchUpInside);
        self.view.addSubview(nowpositionButton);
    }
    
    internal func now_btn_click(sender: UIButton)
    {
        print("button is clcked!")
        //userDefault保存
        let defaults = NSUserDefaults.standardUserDefaults()
        let nowButtonData = "nowButtonData"
        
        defaults.setObject(nowButtonData, forKey: "nowButtonData")
        nowlocationManager = CLLocationManager()
        nowlocationManager.delegate = self
        nowlocationManager.desiredAccuracy = kCLLocationAccuracyBest
        nowlocationManager.distanceFilter = 100
        self.locationManager.startUpdatingLocation()
    }
    
    // 位置情報取得に成功したときに呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        var lat = manager.location!.coordinate.latitude
        var log = manager.location!.coordinate.longitude
        
        userLocation = CLLocationCoordinate2DMake(manager.location!.coordinate.latitude, manager.location!.coordinate.longitude)

        let userLocAnnotation: MKPointAnnotation = MKPointAnnotation()
        userLocAnnotation.coordinate = userLocation
        //userLocAnnotation.title = "現在地"
        mapView.addAnnotation(userLocAnnotation)
        //現在地ピン削除
        self.mapView.removeAnnotations(self.mapView.annotations)
        mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: false)
        
        let defaults = NSUserDefaults.standardUserDefaults()
//        let nowButtonData: String = defaults.objectForKey("nowButtonData") as? String
//        if(nowButtonData != ""){
            if(goalText.text != ""){
                // 現在地から目的地の経路を検索
                getRoute()
            }
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError){
        print("locationManager error", terminator: "")
    }
    
    func getNowPosition(lat: Double,log: Double)
    {
        // MapViewの生成.
        mapView = MKMapView()
        // MapViewのサイズを画面全体に.
        mapView.frame = self.view.bounds
        // Delegateを設定.
        mapView.delegate = self
        // MapViewをViewに追加.
        self.view.addSubview(mapView)
        // 中心点の緯度経度.
        let myLat: CLLocationDegrees = lat
        let myLon: CLLocationDegrees = log
        let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon)
        // 縮尺.
        let myLatDist : CLLocationDistance = 1000
        let myLonDist : CLLocationDistance = 1000
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, myLatDist, myLonDist);
        // MapViewに反映.
        mapView.setRegion(myRegion, animated: true)
    }
    
    func getRoute()
    {
        // メートルで距離を計算
        let userLat = userLocation.latitude
        let userLot = userLocation.longitude
        let startLocation = CLLocation(latitude: userLocation.latitude,longitude: userLocation.longitude)
        let goalLocation = CLLocation(latitude: destLocation.latitude,longitude: destLocation.longitude)
        let distance = startLocation.distanceFromLocation(goalLocation)
        
        let manager = AFHTTPRequestOperationManager()
        var param:Dictionary<String, Double> = ["lat" : userLat, "lon" : userLot]
        manager.POST("http://153.126.185.130:8080/api/v1/address_create?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                //userDefault保存
                let defaults = NSUserDefaults.standardUserDefaults()
                let address01 = responseObject["response"]!!["address"]
                defaults.setObject(address01!!, forKey: "nowaddress01")
                
                let successful = defaults.synchronize()
                if successful {
                    print("データの保存に成功しました。")
                }
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
        // 現在地と目的地のMKPlacemarkを生成
        var fromPlacemark = MKPlacemark(coordinate:userLocation, addressDictionary:nil)
        var toPlacemark   = MKPlacemark(coordinate:destLocation, addressDictionary:nil)
        
        // MKPlacemark から MKMapItem を生成
        var fromItem = MKMapItem(placemark:fromPlacemark)
        var toItem   = MKMapItem(placemark:toPlacemark)
        
        // MKMapItem をセットして MKDirectionsRequest を生成
        let request = MKDirectionsRequest()
        
        request.source = fromItem
        request.destination = toItem
        request.requestsAlternateRoutes = false // 単独の経路を検索
        request.transportType = MKDirectionsTransportType.Any
        
        let directions = MKDirections(request:request)
        directions.calculateDirectionsWithCompletionHandler({
            (response, error) -> Void in
            
            response?.routes.count
            if (error != nil || response!.routes.isEmpty) {
                return
            }
            var route: MKRoute = response!.routes[0] as MKRoute
            // 経路を描画
            self.mapView.addOverlay(route.polyline)
            
            //ゴールピン表示goalLocation
            let goalLocAnnotation: MKPointAnnotation = MKPointAnnotation()
            goalLocAnnotation.coordinate = self.destLocation
            self.mapView.addAnnotation(goalLocAnnotation)
            
            // 現在地と目的地を含む表示範囲を設定する
            self.showUserAndDestinationOnMap()
            
        })
        //現在地フィールド表示
        let defaults = NSUserDefaults.standardUserDefaults()
        let goal01: String = defaults.objectForKey("goal01") as! String
        let nowaddress01: String = defaults.objectForKey("nowaddress01") as! String
        startText.text = "現在地:" + nowaddress01
        goalText.text = "目的地:" + goal01
        self.startText.enabled = false
        self.goalText.enabled = false
        self.view.addSubview(startLabel)
        self.view.addSubview(goalLabel)
        self.view.addSubview(startText)
        self.view.addSubview(goalText)
        self.view.addSubview(maker_icon_g)
        self.view.addSubview(maker_icon)
        
        // 100M以内で配送完了ボタン設置　Ver2.0以上
//        if(distance < 100){
//            self.finishbutton()
//        }
    }
    
    // 地図の表示範囲を計算
    func showUserAndDestinationOnMap()
    {
        // 現在地と目的地を含む矩形を計算
        let maxLat:Double = fmax(userLocation.latitude,  destLocation.latitude)
        let maxLon:Double = fmax(userLocation.longitude, destLocation.longitude)
        let minLat:Double = fmin(userLocation.latitude,  destLocation.latitude)
        let minLon:Double = fmin(userLocation.longitude, destLocation.longitude)
        
        // 地図表示するときの緯度、経度の幅を計算
        let mapMargin:Double = 1.5;  // 経路が入る幅(1.0)＋余白(0.5)
        let leastCoordSpan:Double = 0.005;    // 拡大表示したときの最大値
        let span_x:Double = fmax(leastCoordSpan, fabs(maxLat - minLat) * mapMargin);
        let span_y:Double = fmax(leastCoordSpan, fabs(maxLon - minLon) * mapMargin);
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(span_x, span_y);
        
        // 現在地を目的地の中心を計算
        let center:CLLocationCoordinate2D = CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
        let region:MKCoordinateRegion = MKCoordinateRegionMake(center, span);
        
        mapView.setRegion(mapView.regionThatFits(region), animated:true);
    }
    
    // 経路を描画するときの色や線の太さを指定
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKPolylineRenderer();
    }

    func startbutton() {
        // Buttonを生成する.
        myButton = UIButton()
        // サイズを設定する.
        myButton.frame = CGRectMake(0,0,298,39)
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.hex("DC5878", alpha: 1)
        // 枠を丸くする.
        myButton.layer.masksToBounds = false
        // タイトルを設定する(通常時).
        myButton.setTitle("運送を開始する", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 3.0
        // ボタンの位置を指定する.
        print(self.view.frame.height)
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 50)
        // タグを設定する.
        myButton.tag = 1
        // イベントを追加する.
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
    }
    func stopbutton() {
        // Buttonを生成する.
        stopButton = UIButton()
        
        // サイズを設定する.
        stopButton.frame = CGRectMake(0,0,self.view.frame.width/2 - 30 ,40)
        
        // 背景色を設定する.
        stopButton.backgroundColor = UIColor.hex("DC5878", alpha: 1)
        
        // 枠を丸くする.
        stopButton.layer.masksToBounds = false
        
        // タイトルを設定する(通常時).
        stopButton.setTitle("運送を中止する", forState: UIControlState.Normal)
        stopButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        // コーナーの半径を設定する.
        stopButton.layer.cornerRadius = 3.0
        
        // ボタンの位置を指定する.
        stopButton.layer.position = CGPoint(x: self.view.frame.width/2 - 80, y:self.view.frame.height - 50)
        
        // タグを設定する.
        stopButton.tag = 1
        
        // イベントを追加する.
        stopButton.addTarget(self, action: "onClickStopButton:", forControlEvents: .TouchUpInside)
        
        // ボタンをViewに追加する.
        self.view.addSubview(stopButton)
    }
    func finishbutton() {
        // Buttonを生成する.
        finishButton = UIButton()
        // サイズを設定する.
        finishButton.frame = CGRectMake(0,0,self.view.frame.width/2 - 30,40)
        // 背景色を設定する.
        finishButton.backgroundColor = UIColor.hex("66CDCC", alpha: 1)
        // 枠を丸くする.
        finishButton.layer.masksToBounds = false
        // タイトルを設定する(通常時).
        finishButton.setTitle("運送を終了する", forState: UIControlState.Normal)
        finishButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // コーナーの半径を設定する.
        finishButton.layer.cornerRadius = 3.0
        // ボタンの位置を指定する.
        finishButton.layer.position = CGPoint(x: self.view.frame.width/2 + 80, y:self.view.frame.height - 50)
        // タグを設定する.
        finishButton.tag = 1
        // イベントを追加する.
        finishButton.addTarget(self, action: "onClickFinishButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(finishButton)
    }
    
    internal func onClickMyButton(sender: UIButton){
        self.myButton.hidden = true
        
        // 現在地ボタン非表示
        self.nowpositionButton.hidden = true

        // ストップボタン表示
        stopbutton()
        // 完了ボタン表示
        finishbutton()
        
        
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        
        // 帰ってきたデータを文字列に変換.
        var myData:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        dispatch_async(dispatch_get_main_queue(), {
            print(myData as String)
        })
    }
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
  
        print("URLSessionDidFinishEventsForBackgroundURLSession")
  
    }
    internal func onClickStopButton(sender: UIButton){
        
        // goalLabel enable false
        self.goalText.enabled = false
        // button　非表示
        self.stopButton.hidden = true
        self.finishButton.hidden = true
        
        //荷物一覧画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("MySidePanelControllerViewController") as! UIViewController
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
       
    }
    internal func onClickFinishButton(sender: UIButton){
        
        //userDefaults key:goal01削除
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("goal01")
        defaults.removeObjectForKey("nowaddress01")
        defaults.removeObjectForKey("nowLat")
        defaults.removeObjectForKey("nowLog")
        defaults.removeObjectForKey("nowButtonData")
        
        let successful = defaults.synchronize()
        if successful {
            print("データの削除に成功しました。")
        }
        
        //BaggageListからの値渡し受け取り
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var sendOrderId = appDelegate.sendData
        
        //座標を送信
        let userLat = userLocation.latitude
        let userLong = userLocation.longitude
        
        //現在時間取得
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createdAt = formatter.stringFromDate(now)
        
        // 運送状況の位置情報送信　order_id　latitude　longitude　created_at
        let manager = AFHTTPRequestOperationManager()
        let param = ["order_id" : sendOrderId!,"latitude" : userLat,"longitude":userLong,"created_at":createdAt]

        manager.POST("http://153.126.185.130:8080/api/v1/location_infos?", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                print(responseObject["common"])
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                
                print("Error: \(error)")
                
        })
        
        //運送完了画面へ遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mySecondViewController = storyboard.instantiateViewControllerWithIdentifier("DeliveryCompletedMenuController") as! UIViewController
        
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // View移動
        self.presentViewController(mySecondViewController, animated: true, completion: nil)

        //ボタン非表示
        self.finishButton.hidden = true
    }
    func getHttp(res:NSURLResponse?,data:NSData?,error:NSError?){
        
        // 帰ってきたデータを文字列に変換.
        if(data != nil){
            var myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(myData)
        }
    }
    
    
}

