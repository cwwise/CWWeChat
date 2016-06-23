//
//  CWTextMessageDispatchOperation.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWTextMessageDispatchOperation: CWMessageDispatchOperation {

    override func sendMessage() {
        
        guard let chatMessage = self.chatMessage else {
            return
        }
        
        let toId = chatMessage.messageSendId
        let messageId = chatMessage.messageID
        let content = chatMessage.content

        let sendResult = messageTransmitter.sendMessage(content!, toId: toId!, messageId: messageId)
        messageSendCallback(sendResult)
    }
    
}
