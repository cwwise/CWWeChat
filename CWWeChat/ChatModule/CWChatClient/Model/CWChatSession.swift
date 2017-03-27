//
//  CWChatSession.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 消息会话
class CWChatSession: NSObject {

    private(set) var targetId: String
    /// 类型
    private(set) var type: CWChatType
    /// 最近一条消息
    var lastMessage: CWChatMessage?
    /// 是否置顶
    var isTop: Bool = false
    /// 草稿
    var draft: String?
    /// 未读
    var unreadCount: Int = 0
    
    init(targetId: String, type: CWChatType) {
        self.targetId = targetId
        self.type = type
    }
    
}
