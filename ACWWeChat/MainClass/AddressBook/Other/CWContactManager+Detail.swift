//
//  CWContactManager+Detail.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

extension CWContactManager {
    
    func contactDetailArrayByUserID(_ userId: String) -> [[CWInformationModel]] {
        let user = CWContactManager.findContact(userId)
        return self.contactDetailArrayByUserInfo(user!)
    }
    
    func contactDetailArrayByUserInfo(_ user: CWContactUser) -> [[CWInformationModel]] {
        
        var contactDetailArray = [[CWInformationModel]]()
        
        // 首行
        let userInfo = CWInformationModel(title: "个人", type: .other)
        contactDetailArray.append([userInfo])
        
        let telephone = CWInformationModel(title: "电话号码", subTitle: "18810109052")
        telephone.showDisclosureIndicator = false
        telephone.disableHighlight = true
        
        if (user.remarkName == nil) {
            let remark = CWInformationModel(title: "设置备注和标签")
            contactDetailArray.append([telephone,remark])
        } else {
            let remark = CWInformationModel(title: "标签", subTitle: "大学朋友")
            contactDetailArray.append([telephone,remark])
        }
        
        // 第三部分
        let location = CWInformationModel(title: "地区", subTitle: "广东")
        let album = CWInformationModel(title: "个人相册", type: .other)
        let more = CWInformationModel(title: "更多")
        contactDetailArray.append([location, album, more])
        
        //按钮部分
        let sendMessage = CWInformationModel(title: "发消息", type: .button)
        let videoMessage = CWInformationModel(title: "视频聊天", type: .button)

        contactDetailArray.append([sendMessage, videoMessage])
        
        return contactDetailArray
    }
    
}
