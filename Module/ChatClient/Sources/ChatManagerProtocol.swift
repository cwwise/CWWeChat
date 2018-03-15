//
//  ChatManager.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public protocol ChatManagerDelegate: class {
    
    /// 接受到消息
    ///
    /// - Parameter message: 消息实体
    func didReceive(message: Message)
    
    func conversationDidUpdate(_ conversation: Conversation)
    
}

public extension ChatManagerDelegate {
    func didReceive(message: Message) {}
    func conversationDidUpdate(_ conversation: Conversation) {}
}

public typealias SendMessageCompletionHandle = (Message, ChatClientError?) -> Void

public typealias SendMessageProgressBlock = (Float) -> Void

/// 聊天管理
public protocol ChatManager: class {
    
    /// 添加聊天代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addDelegate(_ delegate: ChatManagerDelegate)
    
    func addDelegate(_ delegate: ChatManagerDelegate, delegateQueue: DispatchQueue)
    
    /// 删除聊天代理
    ///
    /// - Parameter delegate: 代理
    func removeDelegate(_ delegate: ChatManagerDelegate)
    
    /// 获取所有会话
    ///
    /// - Returns: 会话列表
    func fetchAllConversations() -> [Conversation]
    
    func fecthConversation(chatType: ChatType, conversationId: String) -> Conversation
    
    /// 删除会话
    ///
    /// - Parameters:
    ///   - targetId: 会话id
    ///   - deleteMessages: 是否删除会话中的消息
    func deleteConversation(_ conversationId: String, deleteMessages: Bool)
    
    func sendMessage(_ message: Message,
                     progress: SendMessageProgressBlock?,
                     completion: @escaping SendMessageCompletionHandle)
    
    func revokeMessage(_ message: Message, completion: SendMessageCompletionHandle)

}
