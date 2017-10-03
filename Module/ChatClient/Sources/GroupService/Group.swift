//
//  Group.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import Foundation

public class Group {
    
    // 群组ID
    var groupId: String
    // 群组的主题
    var name: String = ""
    // 群组的描述
    var introduce: String = ""
    // 群组属性配置
    var setting: GroupOptions 
    // 群组的所有者
    var owner: String!
    // 群组的成员列表
    var memberList: [String] = [String]()
    // 此群是否为公开群
    var isPublic: Bool = false
    
    init(groupId: String) {
        self.setting = GroupOptions()
        self.groupId = groupId
    }
    
}
