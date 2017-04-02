//
//  CWMenuItem.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMenuItem: NSObject {
    
    ///左侧icon路径
    var iconImageName: String
    ///标题
    var title: String
    
    ///副图片URL
    var rightIconURL: String?
    
    ///是否显示红点
    var showRightRedPoint: Bool
    
    init(iconImageName: String, title: String) {
        self.iconImageName = iconImageName
        self.title = title
        self.showRightRedPoint = false
        super.init()
    }
    
}
