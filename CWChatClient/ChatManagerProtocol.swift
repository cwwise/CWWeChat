//
//  ChatManager.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public protocol ChatManagerDelegate: class {

}

public typealias SendMessageCompletionHandle = (_ message: Message, _ error: ChatClientError?) -> Void

public typealias SendMessageProgressBlock = (_ progress: Float) -> Void

/// 聊天管理
public protocol ChatManager: class {
    
    /// 添加聊天代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addDelegate(_ delegate: ChatManagerDelegate)
    
    /// 删除聊天代理
    ///
    /// - Parameter delegate: 代理
    func removeDelegate(_ delegate: ChatManagerDelegate)
    
    /// 获取所有会话
    ///
    /// - Returns: 会话列表
    func fetchAllConversations() -> [Conversation]
    
    func fecthConversation(chatType: ChatType, conversationId: String) -> Conversation
    
    func sendMessage(_ message: Message,
                     progress: SendMessageProgressBlock?,
                     completion: @escaping SendMessageCompletionHandle)
    
    func revokeMessage(_ message: Message, completion: SendMessageCompletionHandle)

}
