//
//  CWChatMessageHandle.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import MMXXMPPFramework

class CWChatMessageHandle: CWBaseMessageHandle {

    override func handleMessage(message: XMPPMessage) {

        if message.type() == CWXMPPMessageChatType {
            
            let from = message.from().user
            let to = message.to().user
            
            let (body, type) = self.analyMessageContent(message)

            let messageObject = CWMessageModel()
            messageObject.messageSendId = to
            messageObject.messageReceiveId = from
            messageObject.content = body
            messageObject.messageID = message.attributeForName("id").stringValue()
            messageObject.messageOwnerType = .Other
            messageObject.chatType = .Personal
            messageObject.messageType = type
            //如果是离线消息，则消息时间，重新设置。
            //2016-06-25T17:11:13.354Z
            let delayElement = message.elementForName("delay")
            if (delayElement != nil) {
                let formatter = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                let delayTime = delayElement.attributeStringValueForName("stamp")
                messageObject.messageSendDate = ChatTimeTool.dateFromString(delayTime, formatter: formatter)
            }
            
            if let delegate = self.delegate  {
                delegate.handleResult(self, message: messageObject, isDelay: false)
            }
            
        }
        
    }
    
}
