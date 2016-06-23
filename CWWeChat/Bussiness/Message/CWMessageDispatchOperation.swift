//
//  CWMessageDispatchOperation.swift
//  CWChat
//
//  Created by chenwei on 16/4/10.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import CocoaLumberjack

///重复发送次数
let Max_RepeatCount:Int = 5

/// 发送消息的基类
class CWMessageDispatchOperation: NSOperation {
    
    weak var chatMessage: CWMessageProtocol?
        /// 进度回调的block
    var progressBlock: ((Float,Bool)-> Void)?
    
    /// 控制并发的变量
    override var executing: Bool {
        return local_executing
    }
    
    override var finished: Bool {
        return local_finished
    }
    
    override var cancelled: Bool {
        return local_cancelled
    }
    
    /// 实现并发需要设置为YES
    override var concurrent: Bool {
        return true
    }
    
    override var asynchronous: Bool {
        return true
    }
    
    ///控制并发任务的变量
    private var local_executing:Bool = false {
        willSet {
            self.willChangeValueForKey("isExecuting")
        }
        didSet {
            self.didChangeValueForKey("isExecuting")
        }
    }
    private var local_finished:Bool = false {
        willSet {
            self.willChangeValueForKey("isFinished")
        }
        didSet {
            self.didChangeValueForKey("isFinished")
        }
    }
    private var local_cancelled:Bool = false {
        willSet {
            self.willChangeValueForKey("isCancelled")
        }
        didSet {
            self.didChangeValueForKey("isCancelled")
        }
    }
    
    var messageSendResult:Bool
    //重复执行的次数
    internal var repeatCount: Int = 0
    
    //简化代码
    var messageTransmitter: CWMessageTransmitter {
        return CWMessageTransmitter.shareMessageTransmitter()
    }
    
    /**
     根据消息类型生成对应的Operation
     
     - parameter message: 消息体
     
     - returns: 返回对应的消息Operation
     */
    class func dispatchOperationWithMessage(message:CWMessageProtocol) -> CWMessageDispatchOperation {
        
        if message.messageType == .Text {
            return CWTextMessageDispatchOperation(message:message)
        }
        else if message.messageType == .Image {
            return CWImageMessageDispatchOperation(message:message)
        }
        else {
            return CWMessageDispatchOperation(message:message)
        }
    }
    
    init(message: CWMessageProtocol) {
        self.chatMessage = message
        repeatCount = 1
        messageSendResult = false
        super.init()
    }
    
    ///函数入口
    override func start() {
        //疑问
        if NSThread.isMainThread() {
            
        }
        
        if self.finished || self.cancelled {
            self.endOperation()
            return
        }
        self.local_executing = true
        self.performSelectorInBackground(#selector(CWMessageDispatchOperation.main), withObject: nil)
    }
    
    override func cancel() {
        
        self.local_cancelled = true
        super.cancel()
    }

    ///主要执行的过程
    override func main() {
    
        if self.finished || self.cancelled {
            self.endOperation()
            return
        }
        
        messageTransmitter.addDelegate(self, delegateQueue: nil)
        //发送消息的任务
        sendMessage()
    }
    
    ///发送消息
    func sendMessage() {
//        endOperation()
    }
    
    ///消息状态
    func noticationWithOperationState(state:Bool = false) {
        self.messageSendResult = state
        endOperation()
    }
    
    /**
     结束线程
     */
    func endOperation() {
        self.local_executing = false
        self.local_finished = true
        messageTransmitter.removeDelegate(self)
    }

    
    deinit {
        DDLogDebug("operation销毁")
    }
    
}

extension CWMessageDispatchOperation:CWMessageTransmitterDelegate {
   
    func messageSendCallback(result:Bool) {
        if result == false {
            repeatCount += 1
            if repeatCount > Max_RepeatCount {
                messageTransmitter.removeDelegate(self)
                noticationWithOperationState(false)
            } else {
                sendMessage()
            }
        } else {
            messageTransmitter.removeDelegate(self)
            noticationWithOperationState(true)
        }
    }
}


