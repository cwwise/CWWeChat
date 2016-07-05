//
//  CWTextMessageDispatchOperation.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 文字消息发送
 
 是文字的情况下，直接发送
 */
class CWTextMessageDispatchOperation: CWMessageDispatchOperation {

    override func sendMessage() {
        
        guard let chatMessage = self.chatMessage else {
            return
        }
        
        let toId = chatMessage.messageTargetId
        let messageId = chatMessage.messageID
        let content = chatMessage.content

        let sendResult = messageTransmitter.sendMessage(content!, toId: toId!, messageId: messageId)
        messageSendCallback(sendResult)
    }
    
}
