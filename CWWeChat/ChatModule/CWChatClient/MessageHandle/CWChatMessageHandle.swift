//
//  CWChatMessageHandle.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

class CWChatMessageHandle: CWMessageHandle {
    
    override func handleMessage(message: XMPPMessage) -> Bool {

        if message.isChatMessageWithBody() {
            // 内容 来源 目标人 消息id
            guard let body = message.body(),
                let from = message.from().user,
                let to = message.to().user,
                let messageId = message.elementID() else {
                return false
            }
            
            var messageDate = Date()
            if message.wasDelayed() {
                messageDate = message.delayedDeliveryDate()
            }
            
            let messageBody = CWTextMessageBody(text: body)
            let chatMessage = CWChatMessage(targetId: from, messageID: messageId, direction: .receive, timestamp: messageDate.timeIntervalSince1970, messageBody: messageBody)
            chatMessage.senderId = to
            
            self.delegate?.handMessageComplete(message: chatMessage)
            
            return true
        }
        return false
    }
    
    
}
