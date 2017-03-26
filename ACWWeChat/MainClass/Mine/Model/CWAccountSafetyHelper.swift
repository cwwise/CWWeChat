//
//  CWAccountSafetyHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAccountSafetyHelper: NSObject {

    var safetySettingData = [CWSettingGroup]()
    
    init(userModel: CWContactUser) {
        
        let usernameItem = CWSettingItem(title: "微信号")
        if let username = userModel.userName  {
            usernameItem.subTitle = username
            usernameItem.showDisclosureIndicator = false
        } else {
            usernameItem.subTitle = "未设置"
        }
        let group1 = CWSettingGroup(items: [usernameItem])
        safetySettingData.append(group1)
        
        //
        let qqItem = CWSettingItem(title: "QQ号", subTitle: "1035264176")
        let phoneItem = CWSettingItem(title: "手机号", subTitle: "18810109052")
        let emailItem = CWSettingItem(title: "邮箱地址", subTitle: "wei18810109052@163.com")
        
        let group2 = CWSettingGroup(items: [qqItem,phoneItem,emailItem])
        safetySettingData.append(group2)
        
        let soundItem = CWSettingItem(title: "声音锁")
        let passwordItem = CWSettingItem(title: "微信密码")
        let safetyItem = CWSettingItem(title: "账户保护")
        let weixinItem = CWSettingItem(title: "微信安全中心")
        
        let group3 = CWSettingGroup(items: [soundItem,passwordItem,safetyItem,weixinItem])
        safetySettingData.append(group3)
        
        super.init()
    }
    
}
