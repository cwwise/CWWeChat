//
//  Conversation.swift
//  ChatClient
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
    
    public func append(message: Message?) {
        lastMessage = message
    }
    
    /// 获取指定ID的消息
    ///
    /// - Parameter messageId: 消息ID
    /// - Returns: 对应ID的消息
    public func loadMessage(with messageId: String) -> Message? {
        
        return nil
    }
    
    static public func ==(lhs: Conversation, rhs: Conversation) -> Bool {
        return lhs.conversationId == rhs.conversationId
    }
}

public typealias ConversationResultCompletion = ([Message], ChatClientError?) -> Void

extension Conversation {
    
    ///  从数据库获取指定数量的消息，取到的消息按时间排序，并且不包含参考的消息，如果参考消息的ID为空，则从最新消息取
    ///
    /// - Parameters:
    ///   - messageId: 参考消息的ID
    ///   - count: 获取的条数
    ///   - searchDirection: 消息搜索方向
    ///   - completion: 完成的回调
    func fetchMessagesStart(from messageId: String? = nil,
                            count: Int = 20,
                            completion: ConversationResultCompletion) {
        
        let messageStore = ChatClient.share.chatService.messageStore
        let result = messageStore.fecthMessages(conversationId: conversationId, count: count)
        completion(result, nil)
    }
    
    
}

 

