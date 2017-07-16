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
            
            //默认是文字
            let bodyType = message.forName("body")?.attribute(forName: "msgtype")?.stringValue ?? "1"
            let bodyValue = Int(bodyType) ?? 1 
            
            var messageDate = Date()
            if message.wasDelayed() {
                messageDate = message.delayedDeliveryDate()
            }
            
            let type = CWMessageType(rawValue: bodyValue) ?? CWMessageType.none
            var messageBody: CWMessageBody!
          
            switch type {
            case .text:
                messageBody = CWTextMessageBody(text: body)
            case .image:
                messageBody = CWImageMessageBody()
                messageBody.messageDecode(string: body)
            default: break
            }
            
            let chatMessage = CWMessage(targetId: from, 
                                        messageID: messageId,
                                        direction: .receive,
                                        timestamp: messageDate.timeIntervalSince1970,
                                        messageBody: messageBody)
            chatMessage.senderId = to
            
            self.delegate?.handMessageComplete(message: chatMessage)
            
            return true
        }
        return false
    }
}
