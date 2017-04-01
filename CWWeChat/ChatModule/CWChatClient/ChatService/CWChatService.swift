//
//  CWChatService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

class CWChatService: NSObject {
    
    /// 消息发送队列
    fileprivate var dispatchManager: CWMessageDispatchManager 
    
    override init() {
        dispatchManager = CWMessageDispatchManager()
        super.init()
    }
    
}


// MARK: - CWChatManager
extension CWChatService: CWChatManager {
    
    func addDelegate(_ delegate: CWChatManagerDelegate) {
        
    }
    
    func addDelegate(_ delegate: CWChatManagerDelegate, delegateQueue: DispatchQueue) {
        
    }
    
    func removeDelegate(_ delegate: CWChatManagerDelegate) {
        
    }
    
    /// 发送回执消息
    func sendMessageReadAck(message: CWChatMessage, completion: CWMessageCompletionBlock) {
        
    }
    
    /// 发送消息
    ///
    /// - Parameters:
    ///   - message: 消息实体
    ///   - progress: 进度 当消息是资源类型时
    ///   - completion: 发送消息结果
    func sendMessage(_ message: CWChatMessage,
                     progress: @escaping CWMessageProgressBlock, 
                     completion: @escaping CWMessageCompletionBlock) {
        
        // 发送消息 先保存到数据库
        
        // 切换到主线程来处理
        let _progress: CWMessageProgressBlock = { (progressValue) in
            DispatchQueue.main.async(execute: { 
                progress(progressValue)
            })
        }
        
        // 先插入到消息列表
        dispatchManager.sendMessage(message, progress: _progress, completion: completion)
    }
 
    
}

