//
//  CWBadgeView.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let BadgeViewWidth:CGFloat = 18

class CWBadgeView: UIView {
    
    var badgeValue:Int = 0 {
        didSet {
            if badgeValue == 0 {
                self.hidden = true
            } else {
                self.hidden = false
            }
        }
    }
    
}
