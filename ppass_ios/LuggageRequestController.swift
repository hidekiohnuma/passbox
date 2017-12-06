//
//  LuggageRequestController.swift
import Foundation
import UIKit

class LuggageRequestController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let luggagerequestView = LuggageRequestView.instance()
        luggagerequestView.frame = self.view.frame
        self.view.addSubview(luggagerequestView)
        luggagerequestView.myLabel.text = "test2"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
