//
//  UIButton+Extensions.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIButton {
    public func setNormalImage(_ image: UIImage, highlighted hlimage: UIImage) {
        self.setImage(image, for: UIControlState())
        self.setImage(hlimage, for: .highlighted)
    }
    
    public func doCircleRadius(_ radiu: CGFloat, borderColor color:UIColor = UIColor.gray) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radiu
        self.layer.borderWidth = 0.5
        self.layer.borderColor = color.cgColor
    }
    
    /**
     button 提交Style
     */
    public func commitStyle() {
        
        //设置字体大小颜色
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .disabled)
        self.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)

        let normalImage = UIImage(named: "button_normal")
        let disableImage = UIImage(named: "button_disable")
        let selectImage = UIImage(named: "button_select")

        self.setBackgroundImage(normalImage?.resizableImage(), for: UIControlState())
        self.setBackgroundImage(selectImage?.resizableImage(), for: .highlighted)
        self.setBackgroundImage(disableImage?.resizableImage(), for: .disabled)
    }
}
