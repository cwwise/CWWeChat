//
//  CWChatService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

class CWChatService: NSObject {
    fileprivate var messageStore: CWChatMessageStore
    fileprivate var conversationStore: CWChatConversationStore
    
    /// 消息发送管理
    fileprivate var dispatchManager: CWMessageDispatchManager
    // TODO: 待修改 修改成自己的属性
    /// 消息接收解析
    fileprivate var messageParse: CWChatMessageParse {
        return CWChatXMPPManager.share.messageParse
    }

    override init() {
        messageStore = CWChatMessageStore(userId: CWChatClient.share.userId)
        conversationStore = CWChatConversationStore(userId: CWChatClient.share.userId)
        
        dispatchManager = CWMessageDispatchManager()
        super.init()
    }
    
    public func saveMessage(_ message: CWChatMessage)  {
        // 更新会话
        var exist: Bool = false
        let conversation = conversationStore.fecthConversation(message.chatType,
                                                               targetId: message.targetId,
                                                               isExist: &exist)
        conversation.appendMessage(message)
        if exist == false {
            conversationStore.addConversation(conversation: conversation)
        } else {
            
        }
        
        // 保存消息
        messageStore.appendMessage(message)
    }
    
}


// MARK: - CWChatManager
extension CWChatService: CWChatManager {
    
    func addDelegate(_ delegate: CWChatManagerDelegate) {
        messageParse.addDelegate(delegate, delegateQueue: DispatchQueue.main)
    }
    
    func addDelegate(_ delegate: CWChatManagerDelegate, delegateQueue: DispatchQueue) {
        messageParse.addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    func removeDelegate(_ delegate: CWChatManagerDelegate) {
        messageParse.removeDelegate(delegate)
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



