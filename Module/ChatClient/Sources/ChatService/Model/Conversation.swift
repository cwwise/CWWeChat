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
/// - chatroom: 讨论组
public enum ChatType : Int {
    case single
    case group
    case chatroom
}

public class Conversation {
    /// 会话id
    public let conversationId: String
    /// 类型
    public let type: ChatType
    /// 是否置顶
    public var isTop: Bool = false
    /// 草稿
    public var draft: String?
    /// 未读数
    public var unreadCount: Int = 0
    /// 会话最后更新时间 (默认为当前时间戳)
    public var timestamp: TimeInterval
    /// 最近一条消息
    public private(set) var lastMessage: Message? {
        didSet {
            if let lastMessage = lastMessage {
                self.timestamp = lastMessage.timestamp
            }
        }
    }
    
    public init(conversationId: String, type: ChatType) {
        self.conversationId = conversationId
        self.type = type
        self.timestamp = ChatClientUtil.currentTime
    }
    
    public func append(message: Message?) {
        lastMessage = message
    }
    
    public func insert(message: Message) {
        let messageStore = ChatClient.share.chatService.messageStore
        messageStore.insert(message: message)
    }
    
    /// 获取指定ID的消息
    ///
    /// - Parameter messageId: 消息ID
    /// - Returns: 对应ID的消息
    public func loadMessage(with messageId: String) -> Message? {
        
        return nil
    }
    
    
}

extension Conversation: Hashable, CustomStringConvertible {
    
    public var description: String {
        return "会话:\(conversationId),类型:\(type)"
    }
    
    public var hashValue: Int {
        return conversationId.hashValue
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
    public func fetchMessagesStart(from messageId: String? = nil,
                            count: Int = 20,
                            completion: ConversationResultCompletion) {
        
        let messageStore = ChatClient.share.chatService.messageStore
        let result = messageStore.fecthMessages(conversationId: conversationId, count: count)
        completion(result, nil)
    }
    
    
    ///  从数据库获取指定类型的消息，取到的消息按时间排序，如果参考的时间戳为负数，则从最新消息取，如果count小于等于0当作1处理
    ///
    /// - Parameters:
    ///   - type: 消息类型
    ///   - timestamp: 参考时间戳
    ///   - count: 获取的条数
    ///   - searchDirection: 消息搜索方向
    ///   - completion: 完成的回调
    public func fetchMessages(with type: MessageType = .text,
                               timestamp: TimeInterval = -1,
                               count: Int = 20,
                               searchDirection: MessageSearchDirection = .down,
                               completion: ConversationResultCompletion) {
        
        
        
        
        
    }
    
    /// 从数据库获取包含指定内容的消息，取到的消息按时间排序，如果参考的时间戳为负数，则从最新消息向前取，如果aCount小于等于0当作1处理
    ///
    /// - Parameters:
    ///   - keyword: 搜索关键字，如果为空则忽略
    ///   - timestamp: 参考时间戳
    ///   - count: 获取的条数
    ///   - searchDirection: 消息搜索方向
    ///   - completion: 完成的回调
    public func fetchMessages(with keyword: String,
                                  timestamp: TimeInterval = -1,
                                  count: Int = 20,
                                  searchDirection: MessageSearchDirection = .down,
                                  completion: ConversationResultCompletion) {
        
        
        
    }
    
}

 

