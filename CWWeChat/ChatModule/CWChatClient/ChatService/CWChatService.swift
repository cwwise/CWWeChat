//
//  CWChatService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import XMPPFramework

/// 聊天模块
/// 继承XMPPModule 主要是因为多代理
class CWChatService: XMPPModule {
    
    /// 消息存储
    lazy private(set) var messageStore: CWChatMessageStore = {
        let messageStore = CWChatMessageStore(userId: CWChatClient.share.userId)
        return messageStore
    }()
    
    /// 会话存储
    lazy private(set) var conversationStore: CWChatConversationStore = {
        let conversationStore = CWChatConversationStore(userId: CWChatClient.share.userId)
        return conversationStore
    }()
    
    /// xmpp消息发送部分
    private(set) var messageTransmitter: CWMessageTransmitter
    /// 消息发送管理
    fileprivate var dispatchManager: CWMessageDispatchManager
    /// 消息接收解析
    private(set) var messageParse: CWMessageParse
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        // 消息发送和解析
        messageTransmitter = CWMessageTransmitter(dispatchQueue: queue)
        
        messageParse = CWMessageParse()
        dispatchManager = CWMessageDispatchManager()
        super.init(dispatchQueue: queue)
    }

    @objc func didActivate() {
        self.xmppStream.addDelegate(messageParse, delegateQueue: self.moduleQueue)
        messageTransmitter.activate(self.xmppStream)
    }
    
    /// 收到消息执行
    /// 执行 消息变化和会话变化的代理，保存消息
    ///
    /// - Parameter message: 接收到的消息
    public func receiveMessage(_ message: CWMessage) {
        
        executeMessagesDidReceive(message)
        updateConversation(with: message)
        // 保存消息
        messageStore.appendMessage(message)
    }
    
    public func saveMessage(_ message: CWMessage)  {
        
        updateConversation(with: message)
        // 保存消息
        messageStore.appendMessage(message)
    }
    
    public func updateConversation(with message: CWMessage) {
        // 更新会话
        var exist: Bool = false
        let conversation = conversationStore.fecthConversation(message.chatType,
                                                               targetId: message.targetId,
                                                               isExist: &exist)
        conversation.appendMessage(message)
        
        // 执行代理方法
        executeConversationUpdate(conversation)
        // 如果会话不存在 则保存到数据库
        if exist == false {
            conversationStore.addConversation(conversation: conversation)
        }
    }
    
    /// 执行代理方法
    ///
    /// - Parameter message: 消息实体
    private func executeMessagesDidReceive(_ message :CWMessage) {
        
        executeDelegateSelector { (delegate, queue) in
            //执行Delegate的方法
            if let delegate = delegate as? CWChatManagerDelegate {
                queue?.async(execute: {
                    delegate.messagesDidReceive(message)
                })
            }
        }
    }
    
    private func executeConversationUpdate(_ conversation :CWConversation) {

        executeDelegateSelector { (delegate, queue) in
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
    func fetchAllConversations() -> [CWConversation] {
        let list = conversationStore.fecthAllConversations()
        for conversation in list {
            let lastMessage = messageStore.lastMessage(by: conversation.targetId)
            conversation.appendMessage(lastMessage)
        }
        return list
    }
    
    func fecthConversation(chatType: CWChatType, targetId: String) -> CWConversation {
        let conversation = conversationStore.fecthConversation(chatType,
                                                               targetId: targetId)
        return conversation
    }
    
    func deleteConversation(_ targetId: String, deleteMessages: Bool = false) {
        conversationStore.deleteConversation(targetId)
        if deleteMessages {
            messageStore.deleteMessages(targetId: targetId)
        }
    }
    
    func deleteAllConversation() {
    
        // 获取到所有会话
        // 删除所有会话对应的消息，还有聊天文件。
        let list = fetchAllConversations()
        for conversation in list {
            messageStore.deleteMessages(targetId: conversation.targetId)
        }
        conversationStore.deleteConversations()
    }
     
    /// 更新消息
    func updateMessage(_ message: CWMessage, completion: @escaping CWMessageCompletionBlock) {
        messageStore.updateMessage(message)
    }
    
    /// 发送回执消息(不保存消息)
    func sendMessageReadAck(_ message: CWMessage, completion: @escaping CWMessageCompletionBlock) {
        dispatchManager.sendMessage(message, completion: completion)
    }
    
    func messageTransportProgress(_ message: CWMessage) -> Float {
        
        return 0
    }
    
    /// 发送消息
    ///
    /// - Parameters:
    ///   - message: 消息实体
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送消息结果
    func sendMessage(_ message: CWMessage,
                     progress: CWMessageProgressBlock?,
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
                progress?(progressValue)
            })
        }
        
        let _completion: CWMessageCompletionBlock = { (_ message: CWMessage, _ error: CWChatError?) in
            DispatchQueue.main.async(execute: {
                completion(message, error)
            })
        }
        
        // 先插入到消息列表
        dispatchManager.sendMessage(message, progress: _progress, completion: _completion)
    }
    
    /// 重新发送消息
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送完成回调block
    func resendMessage(_ message: CWMessage,
                       progress: @escaping CWMessageProgressBlock,
                       completion: @escaping CWMessageCompletionBlock) {
        
        
        
    }
}



