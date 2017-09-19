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

/// 还需要修改
/// 发送消息线程
class CWMessageDispatchOperation: Operation {
    /// 消息发送
    var messageTransmitter: CWMessageTransmitter {
        let chatService = CWChatClient.share.chatManager as! CWChatService
        return chatService.messageTransmitter
    }
    
    /// 消息实体
    var message: CWMessage
    /// 进度回调的block
    var progress: CWMessageProgressBlock?
    /// 完成结果
    var completion: CWMessageCompletionBlock?
    
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
    
    /// 控制并发任务的变量
    // 执行中
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
    var messageSendResult: Bool
    /// 重复执行的次数
    var repeatCount: Int = 0
    
    class func operationWithMessage(_ message: CWMessage,
                                    progress: CWMessageProgressBlock? = nil,
                                    completion: CWMessageCompletionBlock? = nil) -> CWMessageDispatchOperation {
        
        switch message.messageType {
        case .text:
            return CWTextMessageDispatchOperation(message, progress: progress, completion: completion)
        case .image:
            return CWImageMessageDispatchOperation(message, progress: progress, completion: completion)
        default:
            return CWMessageDispatchOperation(message, progress: progress, completion: completion)
        }
        
    }
    
    init(_ message: CWMessage,
         progress: CWMessageProgressBlock? = nil, 
         completion: CWMessageCompletionBlock? = nil) {
        
        self.message = message
        self.messageSendResult = false
        self.progress = progress
        self.completion = completion
        super.init()
    }
    

    ///函数入口
    override func start() {

        if self.isCancelled {
            self._endOperation()
            return
        }
        
        self.local_executing = true
        self.performSelector(inBackground: #selector(CWMessageDispatchOperation._startOperation), with: nil)
    }
    
    /// 取消线程发送
    override func cancel() {
        if local_cancelled == false {
            local_finished = true
            local_cancelled = true
            local_executing = false
            
            noticationWithOperationState()
        }
        super.cancel()
    }
    
    /// 发送消息
    func sendMessage() {
        noticationWithOperationState()
    }
    
    @objc func _startOperation() {
        //发送消息的任务
        sendMessage()
    }
    
    /**
     结束线程
     */
    func _endOperation() {
        self.local_executing = false
        self.local_finished = true
    }
    
    func _cancelOperation() {
        
    }
    
    /// 消息状态
    func noticationWithOperationState(_ state:Bool = false) {
        self.messageSendResult = state
        _endOperation()
        if state {
            message.sendStatus = .successed
            completion?(message, nil)
        } else {
            message.sendStatus = .failed
            completion?(message, CWChatError(errorCode: .customer, error: "发送失败"))
        }
        
    }
    
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
 
    override var description: String {
        var string = "<\(self.classForCoder) id:\(self.message.messageId) "
        string += " executing:" + (self.local_executing ?"YES":"NO")
        string += " finished:" + (self.local_finished ?"YES":"NO")
        string += " cancelled:" + (self.local_cancelled ?"YES":"NO")
        string += " sendResult:" + (self.messageSendResult ?"YES":"NO")
        string += " >"
        return string
    }
    
    deinit {
        log.debug("销毁:"+self.description)
    }
    
    
}

