//
//  CWMessageInformSettingHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMessageInformSettingHelper: NSObject {

    var messageSettingData = [CWSettingGroup]()
    
    override init() {
        
        let item1 = CWSettingItem(title: "接受新消息通知", subTitle: "已开启")
        let item1FooterTitle = "如果你要关闭或开启微信的新消息通知，请在iPhone的“设置” - “通知”功能中，找到应用程序“微信”更改。"
        let group1 = CWSettingGroup(footerTitle:item1FooterTitle, items: [item1])
        group1.footerTitle = item1FooterTitle
        
        let item2 = CWSettingItem(title: "通知显示消息详情", type: .switch)
        let item2FooterTitle = "关闭后，当收到微信消息时，通知提示将不显示发信人和内容摘要。"
        let group2 = CWSettingGroup(footerTitle:item2FooterTitle, items: [item2])
        
        
        let item3 = CWSettingItem(title: "功能消息免打扰")
        let item3FooterTitle = "设置系统功能消息提示声音和振动时段。"
        let group3 = CWSettingGroup(footerTitle:item3FooterTitle, items: [item3])
        
        let item4 = CWSettingItem(title: "声音", type: .switch)
        let item5 = CWSettingItem(title: "通用", type: .switch)
        let item4FooterTitle = "当微信在运行时，你可以设置是否需要声音或者振动。"
        let group4 = CWSettingGroup(footerTitle:item4FooterTitle, items: [item4,item5])
        
        
        let item6 = CWSettingItem(title: "朋友圈照片更新", type: .switch)
        let item5FooterTitle = "关闭后，有朋友更新照片时，界面下面的“发现”切换按钮上不再出现红点提示。"
        let group5 = CWSettingGroup(footerTitle:item5FooterTitle,items: [item6])
        
        
        messageSettingData.append(group1)
        messageSettingData.append(group2)
        messageSettingData.append(group3)
        messageSettingData.append(group4)
        messageSettingData.append(group5)
        
    }

    
}
