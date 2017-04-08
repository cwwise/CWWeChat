//
//  CWChatGroup.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public class CWChatGroup: NSObject {
    // 群组ID
    var groupId: String
    // 群组的主题
    var subject: String?
    // 群组的描述
    var groupDescription: String?
    // 群组属性配置
    var setting: CWChatGroupOptions = CWChatGroupOptions()
    // 群组的所有者
    var owner: String!
    // 群组的成员列表
    var memberList: [String]!
    // 此群是否为公开群
    var isPublic: Bool = false
    
    init(groupId: String) {
        self.groupId = groupId
    }
}
