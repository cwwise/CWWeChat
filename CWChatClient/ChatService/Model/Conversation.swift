//
//  Conversation.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

/// 聊天类型
///
/// - single: 单聊
/// - group: 群聊
/// - chatRoom: 组聊
public enum ChatType : Int {
    case single
    case group
    case chatroom
}

public class Conversation: NSObject {
    /// 会话id 如果是群聊则是 groupId 单聊则是 对方账号
    public private(set) var conversationId: String
    /// 类型
    public private(set) var type: ChatType
    /// 最近一条消息
    public private(set) var lastMessage: Message?
    /// 是否置顶
    public var isTop: Bool = false
    /// 草稿
    public var draft: String?
    /// 未读
    public var unreadCount: Int = 0
    
    public init(conversationId: String, type: ChatType) {
        self.conversationId = conversationId
        self.type = type
    }
    
    /// 获取指定ID的消息
    ///
    /// - Parameter messageId: 消息ID
    /// - Returns: 对应ID的消息
    public func loadMessage(with messageId: String) -> Message? {
        
        return nil
    }
    
}
