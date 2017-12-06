import Foundation
import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = CommonWebView.instance()
        UIApplication.sharedApplication(
            ).networkActivityIndicatorVisible = true
        
        
        webView.frame = self.view.frame
        //let url: NSURL = NSURL(string: "http://153.126.185.130:8080/app/terms")!
        
        let url: NSURL = NSURL(string: "https://www.facebook.com/")!
        let urlRequest: NSURLRequest = NSURLRequest(URL: url)
        
        webView.loadRequest(urlRequest)
        
        self.view.addSubview(webView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
