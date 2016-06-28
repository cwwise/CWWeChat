//
//  UIButton+Extensions.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIButton {
    public func setNormalImage(image: UIImage, highlighted hlimage: UIImage) {
        self.setImage(image, forState: .Normal)
        self.setImage(hlimage, forState: .Highlighted)
    }
    
    public func doCircleRadius(radiu: CGFloat, borderColor color:UIColor = UIColor.grayColor()) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radiu
        self.layer.borderWidth = 0.5
        self.layer.borderColor = color.CGColor
    }
    
    /**
     button 提交Style
     */
    public func commitStyle() {
        
        //设置字体大小颜色
        self.titleLabel?.font = UIFont.systemFontOfSize(16)
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.3), forState: .Disabled)
        self.setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.6), forState: .Highlighted)

        let normalImage = UIImage(named: "button_normal")
        let disableImage = UIImage(named: "button_disable")
        let selectImage = UIImage(named: "button_select")

        self.setBackgroundImage(normalImage?.resizableImage(), forState: .Normal)
        self.setBackgroundImage(selectImage?.resizableImage(), forState: .Highlighted)
        self.setBackgroundImage(disableImage?.resizableImage(), forState: .Disabled)
    }
}
