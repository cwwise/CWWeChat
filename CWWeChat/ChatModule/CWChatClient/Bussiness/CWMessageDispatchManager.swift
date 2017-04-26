//
//  CWMessageDispatchManager.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/*
 根据xmpp返回的消息来判断 消息是否发送成功
 */

public let kCWMessageDispatchSuccessNotification = NSNotification.Name("kCWMessageDispatchSuccessNotification")

/// 消息发送管理队列
class CWMessageDispatchManager: NSObject {
    /// 队列
    var messageQueue: OperationQueue
    
    override init() {
        messageQueue = OperationQueue()
        messageQueue.name = "发送消息"
        messageQueue.maxConcurrentOperationCount = 5
        messageQueue.isSuspended = false
        super.init()
        monitorNetworkStatus()
        
        NotificationCenter.default.addObserver(forName: kCWMessageDispatchSuccessNotification, object: nil, queue: OperationQueue()) { (notication) in
            
            if let messageIds = notication.userInfo?["messageid"] as? [String] {
                self.sendMessageSuccess(messageIds: messageIds)
            }
            
        }
    }
    
    /// 监听网络状态和XMPP连接状态
    func monitorNetworkStatus() {
        
    }
    
    
    func sendMessage(_ message: CWChatMessage,
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
                    operation.cancel()
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
        log.debug("CWMessageDispatchManager销毁..")
    }
    
    
}
