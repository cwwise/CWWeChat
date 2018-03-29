//
//  ChatService.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import XMPPFramework

///
class ChatService: NSObject, XMPPStreamDelegate {
    
    /// 会话缓存
    fileprivate var conversationCache: [String: Conversation] = [:]
    
    /// 消息存储
    lazy private(set) var messageStore: MessageStore = {
        let messageStore = MessageStore(userId: ChatClient.share.username)
        return messageStore
    }()
    
    /// 会话存储
    lazy private(set) var conversationStore: ConversationStore = {
        let conversationStore = ConversationStore(userId: ChatClient.share.username)
        return conversationStore
    }()
    
    /// xmpp消息发送部分
    private(set) var messageTransmitter: MessageTransmitter
    /// 消息发送管理
    private(set) var dispatchManager: MessageDispatchManager
    /// 消息接收解析
    private(set) var messageParse: MessageParse
    
    var multicastDelegate = GCDMulticastDelegate()
    
    override init() {
        // 消息发送和解析
        messageTransmitter = MessageTransmitter()
        messageParse = MessageParse()
        dispatchManager = MessageDispatchManager()
        
        super.init()
        messageParse.delegate = self
    }
    
    /// 收到消息执行
    /// 执行 消息变化和会话变化的代理，保存消息
    ///
    /// - Parameter message: 接收到的消息
    public func receive(message: Message) {
        // 保存消息
        messageStore.insert(message: message)
        // 执行delegate
        asyncExecuteChat { (delegate) in
            delegate.didReceive(message: message)
        }
        // 更新会话
        updateConversation(with: message)
    }
    
    public func saveMessage(_ message: Message)  {
        
        updateConversation(with: message)
        // 保存消息
        messageStore.insert(message: message)
    }
    
    func updateConversation(with message: Message) {
        
        // 先判断会话是否存在
        guard let conversation = conversationCache[message.conversationId] else {
            
            // 如果不存在 则创建会话 更新
            let conversation = Conversation(conversationId: message.conversationId, type: message.chatType)
            conversationCache[message.conversationId] = conversation
            conversation.append(message: message)

            // 执行添加
            asyncExecuteConversation(action: { (delegate) in
                delegate.didAddConversation(conversation, totalUnreadCount: 0)
            })
            
            // 插入数据库
            conversationStore.insert(conversation: conversation)
            return
        }
        
        // 更新一下会话的最新消息
        conversation.append(message: message)
        asyncExecuteConversation(action: { (delegate) in
            delegate.didUpdateConversation(conversation, totalUnreadCount: 0)
        })
        
    }

    // MARK: XMPPStreamDelegate
    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        messageParse.handle(message: message)
    }
    
    // MARK: - Delegate
    func addDelegate(delegate: Any) {
        multicastDelegate.add(delegate, delegateQueue: DispatchQueue.main)
    }
    
    func removeDelegate(delegate: Any) {
        multicastDelegate.remove(delegate)
    }
    
    /// 删除所有delegate
    func deactivate() {
        multicastDelegate.removeAllDelegates()
    }
    
    // MARK: - 执行方法
    // TODO: 合并这两个方法
    func asyncExecuteChat(action: @escaping (ChatManagerDelegate) -> Void) {
        ///遍历出所有的delegate
        let delegateEnumerator = self.multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        while delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            if let currentDelegate = delegate as? ChatManagerDelegate, let currentQueue = queue {
                currentQueue.async {
                    action(currentDelegate)
                }
            }
        }
    }
    
    func asyncExecuteConversation(action: @escaping (ConversationManagerDelegate) -> Void) {
        ///遍历出所有的delegate
        let delegateEnumerator = self.multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        while delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            if let currentDelegate = delegate as? ConversationManagerDelegate, let currentQueue = queue {
                currentQueue.async {
                    action(currentDelegate)
                }
            }
        }
    }
}

// MARK: - MessageParseDelegate
extension ChatService: MessageParseDelegate {
    
    func successParse(message: Message) {
        receive(message: message)
    }
    
}

extension ChatService: ChatManager {
    
    func addDelegate(_ delegate: ChatManagerDelegate) {
        self.addDelegate(delegate: delegate)
    }
    
    func removeDelegate(_ delegate: ChatManagerDelegate) {
        self.removeDelegate(delegate: delegate)
    }
    
    /// 更新消息
    func updateMessage(_ message: Message) {
        messageStore.updateMessage(message)
    }
    
    func sendMessage(_ message: Message,
                     progress: SendMessageProgressBlock?,
                     completion: @escaping SendMessageCompletionHandle) {
        
        saveMessage(message)
        
        // 切换到主线程来处理
        let _progress: SendMessageProgressBlock = { (progressValue) in
            DispatchQueue.main.async(execute: { 
                progress?(progressValue)
            })
        }
        
        let _completion: SendMessageCompletionHandle = { (message, error) in
            DispatchQueue.main.async(execute: {
                completion(message, error)
            })
        }
        
       dispatchManager.sendMessage(message, progress: _progress, completion: _completion)
        
    }
    
    func revokeMessage(_ message: Message, completion: SendMessageCompletionHandle) {
        
    }
    
}

// MARK: - ConversationManager
extension ChatService: ConversationManager {
    
    func deleteConversation(_ conversation: Conversation, option: Bool) {
        conversationStore.deleteConversation(with: conversation.conversationId)
        if option {
            messageStore.deleteAllMessage(conversationId: conversation.conversationId)
        }
    }
    
    func allConversations() -> [Conversation] {
        let list = conversationStore.fecthAllConversations()
        for conversation in list {
            let lastMessage = messageStore.lastMessage(by: conversation.conversationId)
            conversation.append(message: lastMessage)
        }
        return list
    }
   
    func deleteMessage(_ message: Message) {
        messageStore.deleteMessage(message)
    }
    
    func deleteAllMessages() {
        conversationStore.deleteAllConversations()
    }
    
    func markAllMessagesRead(for conversation: Conversation) {
        messageStore.markAllMessagesAsRead(conversation.conversationId)
    }
    
    func addDelegate(_ delegate: ConversationManagerDelegate) {
        self.addDelegate(delegate: delegate)
    }
    
    func removeDelegate(_ delegate: ConversationManagerDelegate) {
        self.removeDelegate(delegate: delegate)
    }
    
}
