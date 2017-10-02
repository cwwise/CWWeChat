//
//  MessageDispatchManager.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

/*
 消息发送队列Manager
 消息会生成对应的 Operation
 
 1. 网络不通的情况，则等待
 2. 如果网络通 但是socket链接 未链接则等待socket链接成功之后 重试
 
 3. 发送消息 结果按照 回执消息
 
 
 
 */

class MessageDispatchManager: NSObject {
    
    /// 队列
    var messageQueue: OperationQueue = OperationQueue()
    // 消息队列状态
    var messageQueueSuspended: Bool = false
    
    override init() {
        super.init()
        
        messageQueue.name = "发送消息"
        messageQueue.maxConcurrentOperationCount = 5
        messageQueue.isSuspended = messageQueueSuspended
        
        NotificationCenter.default.addObserver(self, selector: #selector(monitorNetworkStatus(_:)), name: kNetworkReachabilityNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendMessageSuccess(_:)), name: kMessageDispatchSuccessNotification, object: nil)
    }
    
    func sendMessage(_ message: Message,
                     progress: SendMessageProgressBlock? = nil,
                     completion: SendMessageCompletionHandle? = nil) {        
        
        // 生成Operation
        let operation = MessageOperation.operation(with: message, progress: progress, completion: completion)
        messageQueue.addOperation(operation)
    }
    
    /// 监听网络状态和XMPP连接状态
    @objc func monitorNetworkStatus(_ notification: Notification) {
        
        guard let status = notification.object as? Bool else {
            return
        }
        /// status = YES messageQueueSuspended = false 网络链接
        // 网络连接不通的时候 将队列挂起
        if status == messageQueueSuspended {
            messageQueueSuspended = status
            messageQueue.isSuspended = messageQueueSuspended
        }
        
    }
    
    // 收到消息id的通知，如果收到消息 本地没有，则不处理。
    // 如果有正在发送的消息 发送成功。
    @objc func sendMessageSuccess(_ notification: Notification) {
        
        guard let messageIds = notification.object as? [String] else {
            return
        }        
        for messageId in messageIds {
            for messageOperation in messageQueue.operations {
                let operation = messageOperation as! MessageOperation
                if operation.message.messageId == messageId {
                    operation.messageSendCallback(true)
                }
            }
        }
        
    }
    
    /// 取消所有线程
    func cancelAllOperation() {
        messageQueue.cancelAllOperations()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        log.debug("CWMessageDispatchManager销毁..")
    }
}
