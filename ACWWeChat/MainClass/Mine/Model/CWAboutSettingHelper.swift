//
//  CWAboutSettingHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAboutSettingHelper: NSObject {

    var aboutSettingData = [CWSettingGroup]()
    override init() {
        
        let item1 = CWSettingItem(title: "去评分")
        let item2 = CWSettingItem(title: "欢迎页")
        let item3 = CWSettingItem(title: "功能介绍")
        let item4 = CWSettingItem(title: "系统通知")
        let item5 = CWSettingItem(title: "投诉")
 
        let group1 = CWSettingGroup(items: [item1,item2,item3,item4,item5])
        aboutSettingData.append(group1)
 
        
    }
}
