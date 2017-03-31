//
//  CWMessageDispatchOperation.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

///重复发送次数
private let kMax_RepeatCount:Int = 5

/// 发送消息线程
class CWMessageDispatchOperation: Operation {
    
    var messageTransmitter: CWMessageTransmitter {
        return CWChatXMPPManager.share.messageTransmitter
    }
    /// 消息实体
    var message: CWChatMessage
    /// 进度回调的block
    var progressBlock: ((Float,Bool)-> Void)?
    
    /// 控制并发的变量
    override var isExecuting: Bool {
        return local_executing
    }
    
    override var isFinished: Bool {
        return local_finished
    }
    
    override var isCancelled: Bool {
        return local_cancelled
    }
    
    override var isReady: Bool {
        return local_ready
    }
    
    /// 实现并发需要设置为YES
    override var isConcurrent: Bool {
        return true
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    ///控制并发任务的变量
    fileprivate var local_executing:Bool = false {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
        }
        didSet {
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    fileprivate var local_finished:Bool = false {
        willSet {
            self.willChangeValue(forKey: "isFinished")
        }
        didSet {
            self.didChangeValue(forKey: "isFinished")
        }
    }
    fileprivate var local_cancelled:Bool = false {
        willSet {
            self.willChangeValue(forKey: "isCancelled")
        }
        didSet {
            self.didChangeValue(forKey: "isCancelled")
        }
    }
    
    internal var local_ready:Bool = false {
        willSet {
            self.willChangeValue(forKey: "isReady")
        }
        didSet {
            self.didChangeValue(forKey: "isReady")
        }
    }
    
    /// 消息发送结果
    var messageSendResult:Bool
    
    /// 重复执行的次数
    var repeatCount: Int = 0
    
    
    class func operationWithMessage(_ message: CWChatMessage) -> CWMessageDispatchOperation {
        
        switch message.messageType {
        case .text:
            return CWTextMessageDispatchOperation(message: message)
        case .image:
            return CWImageMessageDispatchOperation(message: message)
        default:
            return CWMessageDispatchOperation(message: message)
        }
        
    }
    
    init(message: CWChatMessage) {
        self.message = message
        repeatCount = 1
        messageSendResult = false
        super.init()
    }
    
    ///函数入口
    override func start() {
        //疑问
        if Thread.isMainThread {
            
        }
        if self.isFinished || self.isCancelled {
            self.endOperation()
            return
        }
        self.local_executing = true
        self.performSelector(inBackground: #selector(CWMessageDispatchOperation.main), with: nil)
    }
    
    /// 取消线程发送
    override func cancel() {
        self.local_cancelled = true
        super.cancel()
    }
    
    /// 主要执行的过程
    override func main() {
        
        if self.isFinished || self.isCancelled {
            self.endOperation()
            return
        }
            
        //发送消息的任务
        sendMessage()
    }
    

    /// 发送消息
    func sendMessage() {

    }
    
    /// 消息状态
    func noticationWithOperationState(_ state:Bool = false) {
        self.messageSendResult = state
        endOperation()
    }
    
    /**
     结束线程
     */
    func endOperation() {
        self.local_executing = false
        self.local_finished = true
    }
    
    deinit {
        let result = self.messageSendResult == true ? "成功" : "失败"
        log.debug("messageoperation销毁 ---\(message.description) \(result)")
    }
    
    
}

// MARK: - 消息结果反馈
extension CWMessageDispatchOperation {
    
    func messageSendCallback(_ result:Bool) {
        if result == false {
            repeatCount += 1
            if repeatCount > kMax_RepeatCount {
                noticationWithOperationState(false)
            } else {
                sendMessage()
            }
        } else {
            noticationWithOperationState(true)
        }
    }
}


