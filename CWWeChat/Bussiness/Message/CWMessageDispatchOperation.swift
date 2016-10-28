//
//  CWMessageDispatchOperation.swift
//  CWChat
//
//  Created by chenwei on 16/4/10.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

///重复发送次数
let Max_RepeatCount:Int = 5

/// 发送消息的基类
class CWMessageDispatchOperation: Operation {
    
    /// 消息实体
    weak var chatMessage: CWMessageModel?
   
    /**
      进度回调的block
     
      进度条和发送结果。
    */
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
    internal var repeatCount: Int = 0
    
    // BugFix: 只读属性会导致循环引用么？
    /// 简化代码
    var messageTransmitter: CWMessageTransmitter {
        return CWXMPPManager.shareXMPPManager.messageTransmitter
    }
    
    /**
     根据消息类型生成对应的Operation
     
     - parameter message: 消息体
     
     - returns: 返回对应的消息Operation
     */
    class func dispatchOperationWithMessage(_ message:CWMessageModel) -> CWMessageDispatchOperation {
        
        if message.messageType == .text {
            return CWTextMessageDispatchOperation(message:message)
        }
        else if message.messageType == .image {
            return CWImageMessageDispatchOperation(message:message)
        }
        else if message.messageType == .voice {
            return CWVoiceMessageDispatchOperation(message:message)
        }
        else {
            return CWMessageDispatchOperation(message:message)
        }
    }
    
    init(message: CWMessageModel) {
        self.chatMessage = message
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
    
    /**
     发送消息
     
     需要子类重写方法
     */
    func sendMessage() {
//        endOperation()
    }
    
    ///消息状态
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
        CWLogDebug("operation销毁")
    }
    
}

// MARK: - 消息结果反馈
extension CWMessageDispatchOperation {
   
    func messageSendCallback(_ result:Bool) {
        if result == false {
            repeatCount += 1
            if repeatCount > Max_RepeatCount {
                noticationWithOperationState(false)
            } else {
                sendMessage()
            }
        } else {
            noticationWithOperationState(true)
        }
    }
}


