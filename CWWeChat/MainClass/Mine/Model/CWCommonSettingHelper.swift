//
//  CWCommonSettingHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWCommonSettingHelper: NSObject {

    var commonSettingData = [CWSettingGroup]()
    override init() {
        
        let item1 = CWSettingItem(title: "多语言")
        let group1 = CWSettingGroup(items: [item1])
        
        let item2 = CWSettingItem(title: "字体大小")
        let item3 = CWSettingItem(title: "聊天背景")
        let item4 = CWSettingItem(title: "我的表情")
        let item5 = CWSettingItem(title: "朋友圈小视频")
        let group2 = CWSettingGroup(items: [item2,item3,item4,item5])
        
        
        let item6 = CWSettingItem(title: "听筒模式", type: .Switch)
        let group3 = CWSettingGroup(items: [item6])
        
        let item7 = CWSettingItem(title: "功能")
        let group4 = CWSettingGroup(items: [item7])
        
        let item8 = CWSettingItem(title: "聊天记录迁移")
        let item9 = CWSettingItem(title: "清理微信存储空间")
        let group5 = CWSettingGroup(items: [item8,item9])
        
        let item10 = CWSettingItem(title: "清空聊天记录", type: .TitleButton)
        let group6 = CWSettingGroup(items: [item10])
        
        commonSettingData.append(group1)
        commonSettingData.append(group2)
        commonSettingData.append(group3)
        commonSettingData.append(group4)
        commonSettingData.append(group5)
        commonSettingData.append(group6)
        
    }
    
}
