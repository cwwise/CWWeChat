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
}
