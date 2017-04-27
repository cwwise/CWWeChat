//
//  CWTextMessageDispatchOperation.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 文字消息直接发送
class CWTextMessageDispatchOperation: CWMessageDispatchOperation {

    override func sendMessage() {
        
        let toId = message.targetId
        let messageId = message.messageId
        
        let textBody = message.messageBody as! CWTextMessageBody
        let content = textBody.text
        let _ = self.messageTransmitter.sendMessage(content: content,
                                                             targetId: toId, 
                                                             messageId: messageId,
                                                             chatType: message.chatType.rawValue,
                                                             type: message.messageType.rawValue)
        
    }
}
