
import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate{
    
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    var pageImagesArr = Array<String>();
    
    let C_NSUSERDEFAULT_FIRST_TIME = "isFirstTimeDone";
    
    override func viewDidLoad() {
        
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        self.view.backgroundColor = UIColor.whiteColor()
        let pageSize = self.pageImagesArr.count;
        
        //ScrollViewの作成
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(CGFloat(pageSize) * width, 0)//ペーズ数に応じてscrollViewの横幅を長くする。
        self.view.addSubview(scrollView)
        
        //各ページの作成
        for var i = 0; i < pageSize; i++ {
            let img:UIImage = UIImage(named:self.pageImagesArr[i])!;
            let iv:UIImageView = UIImageView(image:img);
            iv.frame = CGRectMake(CGFloat(i) * width, 0, width, height-50);
            scrollView.addSubview(iv)
        }
        
        //UIPageControllの作成
        pageControl = UIPageControl(frame: CGRectMake(0, self.view.frame.maxY - 50, width, 50))
        pageControl.backgroundColor = UIColor.grayColor();
        pageControl.numberOfPages = pageSize
        pageControl.currentPage = 0
        pageControl.userInteractionEnabled = false
        self.view.addSubview(pageControl)
        
        //閉じるボタンの追加
        var button = UIButton(frame: CGRectMake(width-60, 40, 40, 40));
        button.backgroundColor = UIColor.grayColor();
        button.addTarget(self, action: "onClose:", forControlEvents:.TouchUpInside);
        button.setTitle("X", forState: UIControlState.Normal);
        button.layer.masksToBounds = true;
        button.layer.cornerRadius = 20.0
        self.view.addSubview(button);
        
        //NSUserDefaultsに書き込み。チュートリアルは最初の一回だけ表示
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: C_NSUSERDEFAULT_FIRST_TIME);
        NSUserDefaults.standardUserDefaults().synchronize();
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var name = "チュートリアル"
        
        // analytics
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // スクロール数が1ページ分になったら時.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // ページの場所を切り替える.
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
    
    //閉じるボタンが押された
    func onClose(sender: UIButton){
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    //チュートリアルは過去に端末で実行されたか
    func isTutorialDone() ->Bool{
        let obj: Bool = NSUserDefaults.standardUserDefaults().boolForKey(C_NSUSERDEFAULT_FIRST_TIME);
        if (obj){
            return false;
        }
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}