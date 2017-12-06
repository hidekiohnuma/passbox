//
//  TransitionController.swift
//  JASidePanels_Menu_Sample
//

import UIKit

class TransitionController: JASidePanelController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
    }
    
    override func awakeFromNib() {
        self.leftPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"))! as UIViewController
        self.centerPanel = (self.storyboard?.instantiateViewControllerWithIdentifier("MapController"))! as UIViewController
    }
    
}
