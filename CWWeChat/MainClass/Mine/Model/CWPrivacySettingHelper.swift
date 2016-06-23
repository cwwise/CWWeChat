//
//  CWPrivacySettingHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWPrivacySettingHelper: NSObject {
    
    var privacySettingData = [CWSettingGroup]()
    override init() {
        super.init()
        
        let item1 = CWSettingItem(title: "加我为好友时需要验证",type: .Switch)
        let group1 = CWSettingGroup(headerTitle: "通讯录", items: [item1])
        
        let item2 = CWSettingItem(title: "向我推荐QQ好友",type: .Switch)
        let item3 = CWSettingItem(title: "通过QQ号搜索到我",type: .Switch)
        let group2 = CWSettingGroup(items: [item2,item3])
        
        let item4 = CWSettingItem(title: "可通过手机号搜索到我",type: .Switch)
        let item5 = CWSettingItem(title: "向我推荐通讯录好友",type: .Switch)
        let group3 = CWSettingGroup(footerTitle:"开启后，为你推荐已经开通微信的手机联系人",items: [item4,item5])
        
        let item6 = CWSettingItem(title: "通过微信号搜索到我",type: .Switch)
        let group4 = CWSettingGroup(footerTitle:"关闭后，其他用户将不能通过微信号搜索到你",items: [item6])
        
        let item7 = CWSettingItem(title: "通讯录黑名单")
        let group5 = CWSettingGroup(items: [item7])
        
        let item8 = CWSettingItem(title: "不让他(她)看我的朋友圈")
        let item9 = CWSettingItem(title: "不看他(她)的朋友圈")
        let group6 = CWSettingGroup(headerTitle:"朋友圈",items: [item8,item9])
        
        let item10 = CWSettingItem(title: "允许陌生人查看十张照片",type: .Switch)
        let group7 = CWSettingGroup(items: [item10])
        
        privacySettingData.appendContentsOf([group1,group2,group3,group4,group5,group6,group7])
    }
}
