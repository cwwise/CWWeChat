//
//  CWConversationModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 会话模型
public class CWConversationModel: NSObject {

    /// 会话
    private(set) var conversation: CWConversation
    
    var targetId: String {
        return conversation.targetId
    }
    /// 未读消息
    var unreadCount: Int {
        return conversation.unreadCount
    }
    
    /// 最后消息时间
    var lastMessageTime: String {
        
        guard let message = conversation.lastMessage else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: message.timestamp)
        return ChatTimeTool.timeStringFromSinceDate(date)
    }
    
    var conversationTitle: String {
        
        if let draft = self.conversation.draft {
            return "[草稿]"+draft
        }
        
        guard let message = conversation.lastMessage else {
            return ""
        }
        
        switch message.messageType {
        case .text:
            let messageBody = message.messageBody as! CWTextMessageBody
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
    
    init(conversation: CWConversation) {
        self.conversation = conversation
        
        
    }
    
}
