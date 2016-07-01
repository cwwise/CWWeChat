//
//  CWChatMessageHandle.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatMessageHandle: CWBaseMessageHandle {

    override func handleMessage(message: CWXMPPMessage) {

        if message.type == CWXMPPMessageChatType {
            
            let body = message.body
            let from = message.from
            let to = message.to

            let messageObject = CWMessageModel()
            messageObject.messageSendId = to
            messageObject.messageReceiveId = from
            messageObject.content = body
            messageObject.messageID = message.messageId
            messageObject.messageOwnerType = .Other
            messageObject.chatType = .Single
            messageObject.messageType = .Text
            messageObject.composing = message.composing
            //如果是离线消息，则消息时间，重新设置。
            //2016-06-25T17:11:13.354Z
            if let delayDate = message.delayDate {
                messageObject.messageSendDate = delayDate
            }
            
            if let delegate = self.delegate  {
                delegate.handleResult(self, message: messageObject, isDelay: false)
            }
            
        }
        
    }
    
}
