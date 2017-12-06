//
//  MySidePanelController.swift
//  JASidePanels_Menu_Sample
//

import UIKit

class MySidePanelControllerViewController: JASidePanelController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        //Ver2.0にてチュートリアル実装
//        let tutorial = TutorialViewController();
//        if (tutorial.isTutorialDone()){
//            tutorial.pageImagesArr = ["PPass_logo.png","PPass_logo.png","PPass_logo.png"];
//            self.presentViewController(tutorial, animated: true, completion: nil)
//        }
    }
    
    override func awakeFromNib() {
        self.leftPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"))! as UIViewController
        self.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("BaggegeListController"))! as UIViewController
    }
    
}
