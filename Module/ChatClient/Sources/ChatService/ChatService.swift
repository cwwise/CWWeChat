//
//  ChatService.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import XMPPFramework

class ChatService: XMPPModule {

    /// 消息存储
    lazy private(set) var messageStore: ChatMessageStore = {
        let messageStore = ChatMessageStore(userId: ChatClient.share.currentAccount)
        return messageStore
    }()
    
    /// 会话存储
    lazy private(set) var conversationStore: ChatConversationStore = {
        let conversationStore = ChatConversationStore(userId: ChatClient.share.currentAccount)
        return conversationStore
    }()
    
    /// xmpp消息发送部分
    private(set) var messageTransmitter: MessageTransmitter
    /// 消息发送管理
    private(set) var dispatchManager: MessageDispatchManager
    /// 消息接收解析
    private(set) var messageParse: MessageParse
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        // 消息发送和解析
        messageTransmitter = MessageTransmitter()
        messageParse = MessageParse()
        dispatchManager = MessageDispatchManager()
        super.init(dispatchQueue: queue)
    }
    
    /// 收到消息执行
    /// 执行 消息变化和会话变化的代理，保存消息
    ///
    /// - Parameter message: 接收到的消息
    public func receive(message: Message, conversationId: String) {
        
        updateConversation(with: message, conversationId: conversationId)

        executeDidReceiveMessages(message)

        // 保存消息
        messageStore.insert(message: message)
    }
    
    public func saveMessage(_ message: Message)  {
        
       // updateConversation(with: message)
        // 保存消息
        messageStore.insert(message: message)
    }
    
    func updateConversation(with message: Message, conversationId: String) {
        // 更新会话
        var exist: Bool = false
        let conversation = conversationStore.fecthConversation(type: message.chatType,
                                                               conversationId: conversationId,
                                                               isExist: &exist)
        
        // 执行代理方法
        executeConversationUpdate(conversation)
        // 如果会话不存在 则保存到数据库
        if exist == false {
            conversationStore.insert(conversation: conversation)
        }
    }
    
    /// 执行代理方法
    ///
    /// - Parameter message: 消息实体
    private func executeDidReceiveMessages(_ message: Message) {
        
        executeDelegateSelector { (delegate, queue) in
            //执行Delegate的方法
            if let delegate = delegate as? ChatManagerDelegate {
                queue?.async(execute: {
                    delegate.didReceive(message: message)
                })
            }
        }
    }
    
    private func executeConversationUpdate(_ conversation: Conversation) {
        
        executeDelegateSelector { (delegate, queue) in
            //执行Delegate的方法
            if let delegate = delegate as? ChatManagerDelegate {
                queue?.async(execute: {
                    delegate.conversationDidUpdate(conversation)
                })
            }
        }
    }
    
    
}

extension ChatService: XMPPStreamDelegate {

    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        messageParse.handle(message: message)
    }
    
}

extension ChatService: ChatManager {
    func addChatDelegate(_ delegate: ChatManagerDelegate) {
        addChatDelegate(delegate, delegateQueue: DispatchQueue.main)
    }
        
    func addChatDelegate(_ delegate: ChatManagerDelegate, delegateQueue: DispatchQueue) {
        self.addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    func removeChatDelegate(_ delegate: ChatManagerDelegate) {
        self.removeDelegate(delegate)
    }
    
    // MARK: 会话
    func fetchAllConversations() -> [Conversation] {
        let list = conversationStore.fecthAllConversations()
        for conversation in list {
            let lastMessage = messageStore.lastMessage(by: conversation.conversationId)
            conversation.append(message: lastMessage)
        }
        return list
    }
    
    func fecthConversation(chatType: ChatType,
                           conversationId: String) -> Conversation {
        let conversation = conversationStore.fecthConversation(type: chatType,
                                                               conversationId: conversationId)
        return conversation
    }
    
    func deleteConversation(_ conversation: Conversation,
                            deleteMessages: Bool = false) {
        conversationStore.deleteConversation(conversationId: conversation.conversationId)
        if deleteMessages {
            messageStore.deleteAllMessage(conversationId: conversation.conversationId)
        }
    }
    
    
    func sendMessage(_ message: Message,
                     progress: SendMessageProgressBlock?,
                     completion: @escaping SendMessageCompletionHandle) {
        
    }
    
    func revokeMessage(_ message: Message, completion: SendMessageCompletionHandle) {
        
    }
    
}

