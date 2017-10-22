//
//  ChatMessageHandle.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import XMPPFramework

class ChatMessageHandle: MessageHandle {
    
    @discardableResult
    override func handleMessage(_ message: XMPPMessage) -> Bool {
        
        if message.isChatMessageWithBody == false {
           return false
        }
        
        // 内容 来源 目标人 消息id
        guard let body = message.body,
            let from = message.from?.user,
            let _ = message.to?.user,
            let messageId = message.elementID else {
                return false
        }
        
        //默认是文字
        let bodyType = message.forName("body")?.attribute(forName: "msgtype")?.stringValue ?? "1"
        let bodyValue = Int(bodyType) ?? 1 
        let messageType = MessageType(rawValue: bodyValue) ?? .none
        
        var messageDate = ChatClientUtil.currentTime
        if message.wasDelayed == true, let deliveryDate = message.delayedDeliveryDate {
            messageDate = deliveryDate.timeIntervalSince1970
        }
        
        let conversationId = from
        let messageBody = ChatClientUtil.messageBody(with: messageType)
        messageBody.messageDecode(string: body)
        
        let chatMessage = Message(conversationId: conversationId,
                                  from: from,
                                  body: messageBody)
        chatMessage.messageId = messageId
        chatMessage.direction = .receive
        chatMessage.timestamp = messageDate
        
        self.delegate?.handMessageComplete(message: chatMessage)
        return true
    }
    
}
