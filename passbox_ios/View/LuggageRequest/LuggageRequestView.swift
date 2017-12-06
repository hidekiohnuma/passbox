//
//  LuggageRequestView.swift
//  passbox_ios
//
//  Created by 大沼英喜 on 2016/02/25.
//  Copyright © 2016年 Ken Yurino. All rights reserved.
//
import UIKit

class LuggageRequestView: UIView {
    @IBOutlet weak var myLabel: UILabel!
    
    class func instance() -> LuggageRequestView{
        return UINib(nibName: "LuggageRequestView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! LuggageRequestView
    }
}
