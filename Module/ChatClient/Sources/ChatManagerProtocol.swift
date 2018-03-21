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
}

public extension ChatManagerDelegate {
    func didReceive(message: Message) {}
}

public typealias SendMessageCompletionHandle = (Message, ChatClientError?) -> Void

public typealias SendMessageProgressBlock = (Float) -> Void

/// 聊天管理
public protocol ChatManager: class {
    
    /// 添加聊天代理
    ///
    /// - Parameter delegate: 代理
    func addDelegate(_ delegate: ChatManagerDelegate)
    
    /// 删除聊天代理
    ///
    /// - Parameter delegate: 代理
    func removeDelegate(_ delegate: ChatManagerDelegate)
    

    
    func sendMessage(_ message: Message,
                     progress: SendMessageProgressBlock?,
                     completion: @escaping SendMessageCompletionHandle)
    
    func revokeMessage(_ message: Message, completion: SendMessageCompletionHandle)

}
