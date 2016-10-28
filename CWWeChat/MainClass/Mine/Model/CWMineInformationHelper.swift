//
//  CWMineInformationHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/8.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineInformationHelper: NSObject {

    var mineInfoData = [CWSettingGroup]()
    var userInfo: CWContactUser
    init(userInfo: CWContactUser) {
        self.userInfo = userInfo
        super.init()
        self.mineInfoDataByUserInformation(self.userInfo)
    }
    
    func mineInfoDataByUserInformation(_ userInfo: CWContactUser) {
        
        let avatarItem = CWSettingItem(title: "头像")
        avatarItem.rightImageURL = self.userInfo.avatarURL
        
        let nikename = userInfo.nikeName == nil ? userInfo.nikeName : "未设置"
        let nikenameItem = CWSettingItem(title: "名字", subTitle: nikename)
        
        let usernameItem = CWSettingItem(title: "微信号")
        if (userInfo.userName != nil) {
            usernameItem.subTitle = userInfo.userName
            usernameItem.showDisclosureIndicator = false
            usernameItem.disableHighlight = true
        } else {
            usernameItem.subTitle = "未设置"
        }
        
        let qrCodeItem = CWSettingItem(title: "我的二维码")
        qrCodeItem.rightImagePath = "mine_cell_myQR"
        
        let locationItem = CWSettingItem(title: "我的地址")
        
        let group1 = CWSettingGroup(items: [avatarItem, nikenameItem, usernameItem, qrCodeItem, locationItem])
        
        let sexItem = CWSettingItem(title: "性别")
        
        let cityItem = CWSettingItem(title: "地区")
        
        let mottoItem = CWSettingItem(title: "个性签名")
        
        let group2 = CWSettingGroup(items: [sexItem, cityItem, mottoItem])
        
        mineInfoData.append(group1)
        mineInfoData.append(group2)

    }
    
}
