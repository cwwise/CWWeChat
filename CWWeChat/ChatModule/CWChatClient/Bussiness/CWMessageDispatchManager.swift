//
//  CWMessageDispatchManager.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/*
 消息发送队列Manager
 消息会生成对应的 Operation
 
 1. 网络不通的情况，则等待
 2. 如果网络通 但是xmpp链接 未链接则等待xmpp链接成功之后 重试
 
 3. 发送消息 结果按照 XMPPStreamManagementDelegate来处理
 
 根据xmpp返回的消息来判断 消息是否发送成功
 
 
 
 */

/// 消息发送管理队列
class CWMessageDispatchManager: NSObject {
    /// 队列
    var messageQueue: OperationQueue = OperationQueue()
    // 消息队列状态
    var messageQueueSuspended: Bool = false
    
    override init() {
        super.init()
        
        messageQueue.name = "发送消息"
        messageQueue.maxConcurrentOperationCount = 5
        messageQueue.isSuspended = messageQueueSuspended
        
        NotificationCenter.default.addObserver(self, selector: #selector(monitorNetworkStatus(_:)), name: kCWNetworkReachabilityNotification, object: nil)
        
        /// 添加消息发送成功的通知
        NotificationCenter.default.addObserver(forName: kCWMessageDispatchSuccessNotification, object: nil, queue: OperationQueue()) { (notication) in
            
            if let messageIds = notication.object as? [String] {
                self.sendMessageSuccess(messageIds: messageIds)
            }
        }
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
    
    
    func sendMessage(_ message: CWMessage,
                     progress: CWMessageProgressBlock? = nil,
                     completion: CWMessageCompletionBlock? = nil) {        
        
        // 生成Operation
        let operation = CWMessageDispatchOperation.operationWithMessage(message,
                                                                        progress: progress,
                                                                        completion: completion)
        operation.local_ready = true
        messageQueue.addOperation(operation)
    }
    
    // 收到消息id的通知，如果收到消息 本地没有，则不处理。
    // 如果有正在发送的消息 发送成功。
    func sendMessageSuccess(messageIds: [String]) {
        
        for messageId in messageIds {
            for messageOperation in messageQueue.operations {
                let operation = messageOperation as! CWMessageDispatchOperation
                if operation.message.messageId == messageId {
                    operation.messageSendCallback(true)
                }
            }
        }
        
    }
    
    /**
     取消所有线程
     */
    func cancelAllOperation() {
        messageQueue.cancelAllOperations()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        log.debug("CWMessageDispatchManager销毁..")
    }
    
    
}
