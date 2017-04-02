//
//  CWMineSettingHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineSettingHelper: NSObject {

    var mineSettingData = [CWSettingGroup]()
    
    override init() {
        let item1 = CWSettingItem(title: "帐户与安全", subTitle: "已保护")
        item1.rightImagePath = "setting_lockon"
        let group1 = CWSettingGroup(items: [item1])
        
        let item2 = CWSettingItem(title: "新消息通知")
        let item3 = CWSettingItem(title: "隐私")
        //        let item4 = CWSettingItem(title: "设备")
        let item5 = CWSettingItem(title: "通用")
        let group2 = CWSettingGroup(items: [item2,item3,item5])
        
        
        let item6 = CWSettingItem(title: "帮组与反馈")
        let item7 = CWSettingItem(title: "关于微信")
        let group3 = CWSettingGroup(items: [item6,item7])
        
        let item8 = CWSettingItem(title: "退出登录", type: .titleButton)
        
        let group4 = CWSettingGroup(items: [item8])
        
        mineSettingData.append(group1)
        mineSettingData.append(group2)
        mineSettingData.append(group3)
        mineSettingData.append(group4)
    }
    
}
