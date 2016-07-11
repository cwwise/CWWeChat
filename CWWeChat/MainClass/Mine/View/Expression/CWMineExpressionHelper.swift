//
//  CWMineExpressionHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/12.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineExpressionHelper: NSObject {

    var expressionData: [CWSettingGroup]
    
    override init() {
        
        expressionData = [CWSettingGroup]()
        
        let tusijiGroup = CWEmojiGroup();
        tusijiGroup.type = .Image
        tusijiGroup.groupName = "兔斯基"
        tusijiGroup.groupIconPath = "emojiKB_group_tusiji"
        
        let laosijiGroup = CWEmojiGroup();
        laosijiGroup.type = .Image
        laosijiGroup.groupName = "老司机"
        laosijiGroup.groupIconPath = "emojiKB_group_tusiji"

        let group1 = CWSettingGroup(headerTitle: "聊天面板中的表情", items: [tusijiGroup, laosijiGroup])
        expressionData.append(group1)

        
        let item1 = CWSettingItem(title: "添加的表情")
        let item2 = CWSettingItem(title: "购买的表情")

        let group2 = CWSettingGroup(items: [item1,item2])
        expressionData.append(group2)
    }
    
}
