//
//  DeliveryCompletedController.swift
//  JASidePanels_Menu_Sample
//

import UIKit

class DeliveryCompletedMenuController: JASidePanelController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
    }
    
    override func awakeFromNib() {
        self.leftPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"))! as UIViewController
        self.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("CompletedController"))! as UIViewController
    }
    
}
