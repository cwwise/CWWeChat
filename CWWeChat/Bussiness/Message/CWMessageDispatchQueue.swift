//
//  CWMessageDispatchQueue.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 消息发送的结果
protocol CWMessageDispatchQueueDelegate: class {
    //发送消息的结果
    func chatmessageSendState(message:CWMessageModel ,sendState state: Bool)
    //上传数据进度的回调
    func uploadDataProgress(message:CWMessageModel, progress:CGFloat, result:Bool)
}

/**
  消息分发的队列
 
 需要监听网络状态和xmpp连接状态 根据状态来 停止和继续消息发送线程
 
 */
class CWMessageDispatchQueue: NSObject {
    
    /// 消息分发的队列
    weak var delegate: CWMessageDispatchQueueDelegate?
    
    /// 线程队列
    var messageQueue:NSOperationQueue
    
    override init() {
        messageQueue = NSOperationQueue()
        messageQueue.name = "发送消息"
        messageQueue.maxConcurrentOperationCount = 5
        messageQueue.suspended = false
        super.init()
        monitorNetworkStatus()
    }
    
    /// 监听网络状态和XMPP连接状态
    func monitorNetworkStatus() {
        
    }
    
    func sendMessage(message: CWMessageModel, replaceMessage replace:Bool=false) {
        //线程锁
        objc_sync_enter(self)
        //先遍历线程中的。如果存在，则替换
        for operation in messageQueue.operations {
            let messageOperation = operation as! CWMessageDispatchOperation
            let tempMessage = messageOperation.chatMessage
            if tempMessage!.messageID == message.messageID  {
                //替换新的message
                if replace {
                    messageOperation.chatMessage = message
                }
                return
            }
        }
        objc_sync_exit(self)
        
        /// 获取消息
        let operation = CWMessageDispatchOperation.dispatchOperationWithMessage(message)
        operation.local_ready = true
        messageQueue.addOperation(operation)
        
        //Bugfix:这里可能导致循环引用
        /**
         *  消息发送线程完成后，执行的方法。
         */
        operation.completionBlock = { [weak operation] in
            if let delegate = self.delegate {
                delegate.chatmessageSendState(message, sendState: operation!.messageSendResult)
            }
        }
        
        /**
         *  线程线程发送过程中，上传消息进度的反馈
         */
        operation.progressBlock = { [weak self] (progress, result) in
            if let delegate = self!.delegate {
                delegate.uploadDataProgress(message, progress:CGFloat(progress), result: result)
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
        print("ChatMessageTransmitter销毁")
    }
    
}
