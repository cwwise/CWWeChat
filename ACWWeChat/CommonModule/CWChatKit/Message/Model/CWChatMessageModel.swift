//
//  CWChatMessageModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 消息model
class CWChatMessageModel: NSObject {

    /// 聊天消息
    var message: CWChatMessage
    
    /// 是否显示时间
    var showTime: Bool = false

    var messageFrame: CWChatMessageFrame!

    /// 在会话界面显示
    var conversationContent:String {
        switch message.messageObject.type {
        
        case .text:
            return message.text ?? ""
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
    
    
    init(message: CWChatMessage) {
        self.message = message;
    }
    
    
}
