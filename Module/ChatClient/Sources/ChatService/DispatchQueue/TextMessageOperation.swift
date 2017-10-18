//
//  TextMessageOperation.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

class TextMessageOperation: MessageOperation {
    override func sendMessage() {
        
        let toId = message.conversationId
        let messageId = message.messageId
        
        let textBody = message.messageBody as! TextMessageBody
        let content = textBody.text
        
        let messageTransmitter = ChatClient.share.chatService.messageTransmitter
        messageTransmitter.sendMessage(content: content,
                                       targetId: toId,
                                       messageId: messageId,
                                       chatType: message.chatType.rawValue,
                                       type: message.messageType.rawValue)
        
    }
}
