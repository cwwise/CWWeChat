//
//  CWChatDetailHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatDetailHelper: NSObject {

    class func chatDetailDataByUserInfo(_ userInfo: CWContactUser?) -> [CWSettingGroup] {
        
        var dataArray = [CWSettingGroup]()
        
        let users = CWSettingItem(title: "users", type: .other)
        let group1 = CWSettingGroup(items: [users])
        
        let top = CWSettingItem(title: "置顶聊天", type: .switch)
        let screen = CWSettingItem(title: "消息免打扰", type: .switch)
        let group2 = CWSettingGroup(items: [top,screen])

        
        let chatFile = CWSettingItem(title: "聊天文件")
        let group3 = CWSettingGroup(items: [chatFile])

        let chatBG = CWSettingItem(title: "设置当前聊天背景")
        let chatHistory = CWSettingItem(title: "查找聊天内容")
        let group4 = CWSettingGroup(items: [chatBG,chatHistory])
        
        let clear = CWSettingItem(title: "清空聊天记录")
        clear.showDisclosureIndicator = false
        let group5 = CWSettingGroup(items: [clear])
        
        let report = CWSettingItem(title: "举报")
        let group6 = CWSettingGroup(items: [report])
        
        dataArray.append(contentsOf: [group1,group2,group3,group4,group5,group6])
        
        return dataArray
    }
    
    
}
