import UIKit

class ChatRoomController: UIViewController, UITableViewDelegate ,UITableViewDataSource, UITabBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var ChatRooms:[ChatRoom] = [ChatRoom]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFriends()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        var nib = UINib(nibName: "ChatRoomView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        
        
        let footerView = FooterView.instance()
        footerView.delegate = self
        footerView.frame = CGRectMake(0, self.view.frame.size.height - 52, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(footerView)
    }
    
    func setupFriends() {
        // api取得
        var UserId = 2
        let manager = AFHTTPRequestOperationManager()
        var param = ["user_id" : UserId]
        
        manager.GET("http://153.126.185.130:8080/api/v1/users/2/chat_rooms?",parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                let chatListCount = responseObject["response"]!!["chat_room_lists"]
                var count = chatListCount!!.count

                for i in 0..<count{
                    let img = responseObject["response"]!!["chat_room_lists"]!![i]["user_image"]!
                    let companyName = responseObject["response"]!!["chat_room_lists"]!![i]["company_name"]!
                    let userName = responseObject["response"]!!["chat_room_lists"]!![i]["message"]!
                    let created = responseObject["response"]!!["chat_room_lists"]!![i]["last_created_at"]!

                    var i = ChatRoom(label1: companyName as? String, label2:userName as? String,label3:created as? String,imageName:(img as? String)!)
                    self.ChatRooms.append(i)
                }

                // tableをリロードしてデータ取得
                self.tableView.reloadData()
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                print("Error: \(error)")
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return ChatRooms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? ChatRoomView
        
        //cell中身セット（引数　セル、indexPath）
        cell?.setCell(ChatRooms[indexPath.row])
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
