//
//  CWChatConversation.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 消息会话
public class CWChatConversation: NSObject {
    /// 目标
    private(set) var targetId: String
    /// 类型
    private(set) var type: CWChatType
    /// 最近一条消息
    private(set) var lastMessage: CWChatMessage?
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
    
    // MARK: 操作消息
    /// 将消息设置为已读
    ///
    /// - Parameter messageId: 要设置消息的ID
    func markMessageAsRead(messageId: String) {
        
    }
    
    /// 将所有未读消息设置为已读
    func markAllMessagesAsRead() {
        
    }
    
    func appendMessage(_ message: CWChatMessage?) {
        lastMessage = message
    }
    
    /// 获取指定ID的消息
    ///
    /// - Parameter messageId: 消息ID
    /// - Returns: 对应ID的消息
    func loadMessage(with messageId: String) -> CWChatMessage? {
    
        return nil
    }
}

public func ==(lhs: CWChatConversation, rhs: CWChatConversation) -> Bool {
    return lhs.targetId == rhs.targetId
}

public typealias CWConversationResultCompletion = (_ messages: [CWChatMessage], _ error: NSError?) -> Void

// MARK: 查询消息
public extension CWChatConversation {
    
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
        
        
        
        
    }
    
    
    ///  从数据库获取指定类型的消息，取到的消息按时间排序，如果参考的时间戳为负数，则从最新消息取，如果aCount小于等于0当作1处理
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


