//
//  CWChatManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

/// 聊天相关回调
public protocol CWChatManagerDelegate: NSObjectProtocol {
    // MARK: 会话
    
    /// 会话状态发生变化
    ///
    /// - Parameter conversation: 会话
    func conversationDidUpdate(_ conversation: CWChatConversation)
    
    // MARK: Message
    /// 消息状态发生变化
    ///
    /// - Parameter message: 状态发生变化的消息
    /// - Parameter error: 错误信息
    func messageStatusDidChange(_ message: CWChatMessage, error: CWChatError?)
    
    /// 收到消息
    ///
    /// - Parameter message: 消息实体
    func messagesDidReceive(_ message: CWChatMessage)
}

// 让协议变成可选
public extension CWChatManagerDelegate {
    func conversationDidUpdate(_ conversation: CWChatConversation) {}
    func messagesDidReceive(_ message: CWChatMessage) {}
    func messageStatusDidChange(_ message: CWChatMessage, error: CWChatError?) {}
}

/// 消息执行结果回调
public typealias CWMessageCompletionBlock = (_ message: CWChatMessage, _ error: CWChatError?) -> Void
/// 消息进度
public typealias CWMessageProgressBlock = (_ progress: Int) -> Void

/// 聊天相关操作
public protocol CWChatManager: NSObjectProtocol {
    
    /// 添加聊天代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addChatDelegate(_ delegate: CWChatManagerDelegate, delegateQueue: DispatchQueue)
    
    /// 删除聊天代理
    ///
    /// - Parameter delegate: 代理
    func removeChatDelegate(_ delegate: CWChatManagerDelegate)

    // MARK: 获取会话
    
    /// 获取所有会话
    ///
    /// - Returns: 会话列表
    func fetchAllConversations() -> [CWChatConversation]
    
    func fecthConversation(chatType: CWChatType, targetId: String) -> CWChatConversation
    
    /// 删除会话
    ///
    /// - Parameters:
    ///   - targetId: 会话id
    ///   - deleteMessages: 是否删除会话中的消息
    func deleteConversation(_ targetId: String, deleteMessages: Bool)
    func deleteConversation(_ targetId: String)
        
    // MARK: 消息相关
    
    /// 更新消息到DB
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - completion: 回调结果
    func updateMessage(_ message: CWChatMessage, completion: @escaping CWMessageCompletionBlock)
    
    /// 发送回执消息
    ///
    /// - Parameters:
    ///   - message: 回执消息
    ///   - completion: 发送完成回调block
    func sendMessageReadAck(_ message: CWChatMessage,
                            completion: @escaping CWMessageCompletionBlock)
    
    /// 发送消息
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送完成回调block
    func sendMessage(_ message: CWChatMessage,
                     progress: CWMessageProgressBlock?,
                     completion: @escaping CWMessageCompletionBlock)
    
    /// 重新发送消息
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送完成回调block
    func resendMessage(_ message: CWChatMessage,
                     progress: @escaping CWMessageProgressBlock,
                     completion: @escaping CWMessageCompletionBlock)
    
}
