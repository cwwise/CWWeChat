//
//  ConversationModel.swift
//  Pods
//
//  Created by chenwei on 2017/10/3.
//

import Foundation
import ChatClient

public class ConversationModel: NSObject {
    
    /// 会话
    public private(set) var conversation: Conversation
    
    public var conversationId: String {
        return conversation.conversationId
    }
    /// 未读消息
    public var unreadCount: Int {
        return conversation.unreadCount
    }
    
    public var type: ChatType {
        return conversation.type
    }
    
    /// 最后消息时间
    var lastMessageTime: String {
        
        guard let message = conversation.lastMessage else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: message.timestamp)
        return "\(date)"
    }
    
    public var conversationTitle: String {
        
        if let draft = self.conversation.draft {
            return "[草稿]"+draft
        }
        
        guard let message = conversation.lastMessage else {
            return ""
        }
        
        switch message.messageType {
        case .text:
            let messageBody = message.messageBody as! TextMessageBody
            return messageBody.text
        case .image:
            return "[图片]"
        case .voice:
            return "[声音]"
        case .video:
            return "[视频]"
        case .location:
            return "[位置]"
            
        default:
            return "[未知消息]"
        }
        
    }
    
    public init(conversation: Conversation) {
        self.conversation = conversation
    }
    
}
