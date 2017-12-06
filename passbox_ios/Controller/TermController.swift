import UIKit

class TermController: UIViewController, UIWebViewDelegate  {
    var _webView: UIWebView! //Webビュー
    
    private var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "利用規約"
        // インジケータ on
        SVProgressHUD.show()
        loadAddressURL()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "利用規約"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    func loadAddressURL(){
        
        //Webビューの生成
        _webView = makeWebView(CGRectMake(0, 0,
            self.view.frame.width, self.view.frame.height))
        self.view.addSubview(_webView)
        
        //インジケータの表示(2)
        UIApplication.sharedApplication(
            ).networkActivityIndicatorVisible = true
        
        //HTMLの読み込み(3)
        let url: NSURL = NSURL(string: "http://153.126.185.130:8080/app/terms")!
        let urlRequest: NSURLRequest = NSURLRequest(URL: url)
        _webView.loadRequest(urlRequest)
        
    }
    //Webビューの生成
    func makeWebView(frame: CGRect) -> UIWebView {
        //Webビューの生成(1)
        let webView = UIWebView()
        webView.frame = frame
        webView.backgroundColor = UIColor.hex("EEEEEE", alpha: 1)
        webView.scalesPageToFit = true //ページをフィットさせるかどうか
        webView.autoresizingMask = [   //ビューサイズの自動調整
            UIViewAutoresizing.FlexibleRightMargin,
            UIViewAutoresizing.FlexibleTopMargin,
            UIViewAutoresizing.FlexibleLeftMargin,
            UIViewAutoresizing.FlexibleBottomMargin,
            UIViewAutoresizing.FlexibleWidth,
            UIViewAutoresizing.FlexibleHeight]
        webView.delegate = self
        return webView
    }
    func webView(webView: UIWebView,
        shouldStartLoadWithRequest: NSURLRequest,
        navigationType: UIWebViewNavigationType) -> Bool {
            //クリック時
            if navigationType == UIWebViewNavigationType.LinkClicked ||
                navigationType == UIWebViewNavigationType.FormSubmitted {
                    //通信中の時は再度URLジャンプさせない(5)
                    if UIApplication.sharedApplication(
                        ).networkActivityIndicatorVisible {
                            return false
                    }
                    
                    //インジケーターの表示(2)
                    UIApplication.sharedApplication(
                        ).networkActivityIndicatorVisible = true
            }
            return true
    }
    
    //HTML読み込み成功時に呼ばれる(4)
    func webViewDidFinishLoad(webView: UIWebView) {
        //インジケーターの非表示(2)
        UIApplication.sharedApplication(
            ).networkActivityIndicatorVisible = false
        // インジケータ off
        SVProgressHUD.dismiss()
    }
    
    internal func onClickSettingButton(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}