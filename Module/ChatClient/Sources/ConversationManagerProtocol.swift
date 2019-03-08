//
//  ConversationManagerProtocol.swift
//  ChatClient
//
//  Created by chenwei on 2018/3/20.
//

import Foundation

///  会话管理器回调
public protocol ConversationManagerDelegate: class {
    
    /// 添加会话
    ///
    /// - Parameters:
    ///   - conversation: 会话实例
    ///   - totalUnreadCount: 未读数
    func didAddConversation(_ conversation: Conversation, totalUnreadCount: Int)
    
    /// 会话更新
    ///
    /// - Parameters:
    ///   - conversation: 会话实例
    ///   - totalUnreadCount: 未读数
    func didUpdateConversation(_ conversation: Conversation, totalUnreadCount: Int)
    
    /// 删除会话
    ///
    /// - Parameters:
    ///   - conversation: 会话实例
    ///   - totalUnreadCount: 未读数
    func didDeleteConversation(_ conversation: Conversation, totalUnreadCount: Int)
}

/// 会话管理器
public protocol ConversationManager {
    
    /// 删除消息
    ///
    /// - Parameter message: 消息实体
    func deleteMessage(_ message: Message)
    
    /// 获取所有会话
    ///
    /// - Returns: 会话列表
    func allConversations() -> [Conversation]
    
    /// 删除会话
    ///
    /// - Parameters:
    ///   - conversatio: 会话对象
    ///   - option: 是否删除消息
    func deleteConversation(_ conversation: Conversation, option: Bool)
    
    /// 设置一个会话所有消息置为已读
    func markAllMessagesRead(for conversation: Conversation)
    
    /// 添加聊天代理
    ///
    /// - Parameter delegate: 代理
    func addDelegate(_ delegate: ConversationManagerDelegate)
    
    /// 删除聊天代理
    ///
    /// - Parameter delegate: 代理
    func removeDelegate(_ delegate: ConversationManagerDelegate)
}
