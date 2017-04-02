//
//  CWChatService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import XMPPFramework

class CWChatService: XMPPModule {
    // 消息存储
    private(set) var messageStore: CWChatMessageStore
    private(set) var conversationStore: CWChatConversationStore
    
    /// 发送
    private(set) var messageTransmitter: CWMessageTransmitter
    /// 消息发送管理
    fileprivate var dispatchManager: CWMessageDispatchManager
    /// 消息接收解析
    private(set) var messageParse: CWChatMessageParse

    override init() {
        messageStore = CWChatMessageStore(userId: CWChatClient.share.userId)
        conversationStore = CWChatConversationStore(userId: CWChatClient.share.userId)
        
        // 消息发送和解析
        messageTransmitter = CWMessageTransmitter()
        dispatchManager = CWMessageDispatchManager()
        messageParse = CWChatMessageParse()
        super.init()
        messageParse.activate(CWChatXMPPManager.share.xmppStream)
    }
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        
        messageStore = CWChatMessageStore(userId: CWChatClient.share.userId)
        conversationStore = CWChatConversationStore(userId: CWChatClient.share.userId)
        
        // 消息发送和解析
        messageTransmitter = CWMessageTransmitter()
        dispatchManager = CWMessageDispatchManager()
        messageParse = CWChatMessageParse()
        
        super.init(dispatchQueue: queue)
        messageParse.activate(CWChatXMPPManager.share.xmppStream)
    }
    

    
    public func saveMessage(_ message: CWChatMessage)  {
        
        executeMessagesDidReceive(message)
        // 更新会话
        var exist: Bool = false
        let conversation = conversationStore.fecthConversation(message.chatType,
                                                               targetId: message.targetId,
                                                               isExist: &exist)
        conversation.appendMessage(message)
        
        // 执行代理方法
        executeConversationUpdate(conversation)
        if exist == false {
            conversationStore.addConversation(conversation: conversation)
        } else {
            
        }
        
        // 保存消息
        messageStore.appendMessage(message)
    }
    
    private func executeMessagesDidReceive(_ message :CWChatMessage) {
        // 处理事件
        // 检查delegate 是否存在，存在就执行方法
        guard let multicastDelegate = self.value(forKey: "multicastDelegate") as? GCDMulticastDelegate else {
            return
        }
        
        ///遍历出所有的delegate
        let delegateEnumerator = multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        
        while delegateEnumerator?.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            if let delegate = delegate as? CWChatManagerDelegate {
                queue?.async(execute: {
                    delegate.messagesDidReceive(message)
                })
            }
        }
    }
    
    private func executeConversationUpdate(_ conversation :CWChatConversation) {
        // 处理事件
        // 检查delegate 是否存在，存在就执行方法
        guard let multicastDelegate = self.value(forKey: "multicastDelegate") as? GCDMulticastDelegate else {
            return
        }
        
        ///遍历出所有的delegate
        let delegateEnumerator = multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        
        while delegateEnumerator?.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            if let delegate = delegate as? CWChatManagerDelegate {
                queue?.async(execute: {
                    delegate.conversationDidUpdate(conversation)
                })
            }
        }
    }
    
    
}


// MARK: - CWChatManager
extension CWChatService: CWChatManager {
 
    func addChatDelegate(_ delegate: CWChatManagerDelegate, delegateQueue: DispatchQueue) {
        self.addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    func removeChatDelegate(_ delegate: CWChatManagerDelegate) {
        self.removeDelegate(delegate)
    }
    
    // MARK: 会话
    func fetchAllConversations() -> [CWChatConversation] {
        let list = conversationStore.fecthAllConversations()
        for conversation in list {
            let lastMessage = messageStore.lastMessage(by: conversation.targetId)
            conversation.appendMessage(lastMessage)
        }
        return list
    }
    
    func fecthConversation(chatType: CWChatType, targetId: String) -> CWChatConversation {
        let conversation = conversationStore.fecthConversation(chatType,
                                                               targetId: targetId)
        return conversation
    }
    
    /// 发送回执消息(不保存消息)
    func sendMessageReadAck(message: CWChatMessage, completion: @escaping CWMessageCompletionBlock) {
        
        dispatchManager.sendMessage(message, completion: completion)
    }
    
    /// 发送消息
    ///
    /// - Parameters:
    ///   - message: 消息实体
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送消息结果
    func sendMessage(_ message: CWChatMessage,
                     progress: @escaping CWMessageProgressBlock, 
                     completion: @escaping CWMessageCompletionBlock) {

        // 添加信息
        if message.senderId == nil {
            message.senderId = CWChatClient.share.userId
        }
        // 保存消息
        saveMessage(message)
        
        // 切换到主线程来处理
        let _progress: CWMessageProgressBlock = { (progressValue) in
            DispatchQueue.main.async(execute: { 
                progress(progressValue)
            })
        }
        // 先插入到消息列表
        dispatchManager.sendMessage(message, progress: _progress, completion: completion)
    }
    
    /// 重新发送消息
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送完成回调block
    func resendMessage(_ message: CWChatMessage,
                       progress: @escaping CWMessageProgressBlock,
                       completion: @escaping CWMessageCompletionBlock) {
        
        
        
    }
}



