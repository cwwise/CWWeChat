//
//  ChatService.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

class ChatService: NSObject {

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
    
    
    
    
}
