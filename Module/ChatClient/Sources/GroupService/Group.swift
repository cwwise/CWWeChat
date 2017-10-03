//
//  Group.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import Foundation

public class Group {
    
    // 群组ID
    public var groupId: String
    // 群组的主题
    public var name: String = ""
    // 群组的描述
    public var introduce: String = ""
    // 群组属性配置
    public var setting: GroupOptions
    // 群组的所有者
    public var owner: String!
    // 群组的成员列表
    public var memberList: [String] = [String]()
    // 此群是否为公开群
    public var isPublic: Bool = false
    
    init(groupId: String) {
        self.setting = GroupOptions()
        self.groupId = groupId
    }
    
}
