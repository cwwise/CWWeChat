//
//  CWChatManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

/// 聊天相关回调
protocol CWChatManagerDelegate: NSObjectProtocol {
    
}

typealias CWMessageCompletionBlock = (_ message: CWChatMessage, _ error: Error?) -> Void
typealias CWMessageProgressBlock = (_ progress: Int) -> Void

/// 聊天相关操作
protocol CWChatManager: NSObjectProtocol {
    
    /// 添加聊天代理
    ///
    /// - Parameter delegate: 代理
    func addDelegate(_ delegate: CWChatManagerDelegate)
    
    func addDelegate(_ delegate: CWChatManagerDelegate, delegateQueue: DispatchQueue)

    func removeDelegate(_ delegate: CWChatManagerDelegate)
    
    
    // MARK: 发送消息相关
    
    /// 发送回执消息
    ///
    /// - Parameter message: 回执消息
    func sendMessageReadAck(message: CWChatMessage,
                            completion: CWMessageCompletionBlock)
    
    /// 发送消息
    ///
    /// - Parameter message: 消息实体
    func sendMessage(_ message: CWChatMessage,
                     progress: @escaping CWMessageProgressBlock,
                     completion: @escaping CWMessageCompletionBlock)
}
