//
//  CWChatConversation.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 消息会话
public class CWConversation: NSObject {
    /// 目标
    public private(set) var targetId: String
    /// 类型
    public private(set) var type: CWChatType
    /// 最近一条消息
    public private(set) var lastMessage: CWMessage?
    /// 是否置顶
    public var isTop: Bool = false
    /// 草稿
    public var draft: String?
    /// 未读
    public var unreadCount: Int = 0
    
    public init(targetId: String, type: CWChatType) {
        self.targetId = targetId
        self.type = type
    }
    
    // MARK: 操作消息
    /// 将消息设置为已读
    ///
    /// - Parameter messageId: 要设置消息的ID
    public func markMessageAsRead(messageId: String) {
        guard let service = CWChatClient.share.chatManager as? CWChatService else {
            return
        }
        service.messageStore.markMessageRead(targetId, message_Id: messageId)
    }
    
    /// 将所有未读消息设置为已读
    public func markAllMessagesAsRead() {
        guard let service = CWChatClient.share.chatManager as? CWChatService else {
                return
        }
        service.messageStore.markAllMessagesAsRead(self.targetId)
    }
    
    public func appendMessage(_ message: CWMessage?) {
        lastMessage = message
    }
    
    /// 获取指定ID的消息
    ///
    /// - Parameter messageId: 消息ID
    /// - Returns: 对应ID的消息
    public func loadMessage(with messageId: String) -> CWMessage? {
    
        return nil
    }
}

public func ==(lhs: CWConversation, rhs: CWConversation) -> Bool {
    return lhs.targetId == rhs.targetId
}

public typealias CWConversationResultCompletion = (_ messages: [CWMessage], _ error: CWChatError?) -> Void

// MARK: 查询消息
public extension CWConversation {
    
    ///  从数据库获取指定数量的消息，取到的消息按时间排序，并且不包含参考的消息，如果参考消息的ID为空，则从最新消息取
    ///
    /// - Parameters:
    ///   - messageId: 参考消息的ID
    ///   - count: 获取的条数
    ///   - searchDirection: 消息搜索方向
    ///   - completion: 完成的回调
    func fetchMessagesStart(from messageId: String? = nil,
                            count: Int = 20,
                            searchDirection: CWMessageSearchDirection = .down,
                            completion: CWConversationResultCompletion) {
        
        guard let service = CWChatClient.share.chatManager as? CWChatService else {
            completion([], nil)
            return
        }
        
        
        let result = service.messageStore.fecthMessages(targetId: self.targetId,
                                                        count: count)
        
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
    func fetchMessagesWithType(_ type: CWMessageType = .text,
                               timestamp: TimeInterval = -1,
                               count: Int = 20,
                               searchDirection: CWMessageSearchDirection = .down,
                               completion: CWConversationResultCompletion) {
        
        
        
        
        
    }
    
    /// 从数据库获取包含指定内容的消息，取到的消息按时间排序，如果参考的时间戳为负数，则从最新消息向前取，如果aCount小于等于0当作1处理
    ///
    /// - Parameters:
    ///   - keyword: 搜索关键字，如果为空则忽略
    ///   - timestamp: 参考时间戳
    ///   - count: 获取的条数
    ///   - searchDirection: 消息搜索方向
    ///   - completion: 完成的回调
    func fetchMessagesWithKeyword(_ keyword: String,
                               timestamp: TimeInterval = -1,
                               count: Int = 20,
                               searchDirection: CWMessageSearchDirection = .down,
                               completion: CWConversationResultCompletion) {
        
        
        
    }
    
}


