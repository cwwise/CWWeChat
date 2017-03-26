//
//  CWChatMessageHandle.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import XMPPFramework

class CWChatMessageHandle: CWBaseMessageHandle {

    override func handleMessage(_ message: XMPPMessage) {

        if message.type() == CWXMPPMessageChatType {
            
            let from = message.from().user
            let to = message.to().user
            let messageID = message.attribute(forName: "id")?.stringValue
            
            let (body, type) = self.analyMessageContent(message)
            
            var messageContent = CWMessageContent()
            switch type {
            case .text:
                messageContent = CWTextMessageContent(content: body)
            case .image:
                let expand = message.forName("body")?.attribute(forName: "expand")?.stringValue!
                messageContent = CWImageMessageContent(imageURI: body) as CWImageMessageContent
                let imageMessageContent = messageContent as! CWImageMessageContent
                imageMessageContent.imageSize = CGSizeFromString(expand!)
            default:
                messageContent = CWTextMessageContent(content: body)
            }
            
            let messageObject = CWMessageModel(targetId: from!, messageID: messageID!,
                                         ownerType: .other, content: messageContent)
            
            messageObject.content = body
            messageObject.chatType = .personal
            messageObject.messageSendId = to
            
            
            //如果是离线消息，则消息时间，重新设置。
            //2016-06-25T17:11:13.354Z
            let delayElement = message.forName("delay")
            if (delayElement != nil) {
                let formatter = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                let delayTime = delayElement?.attributeStringValue(forName: "stamp")
                messageObject.messageSendDate = ChatTimeTool.dateFromString(delayTime!, formatter: formatter)
            }
            
            if let delegate = self.delegate  {
                delegate.handleResult(self, message: messageObject, isDelay: false)
            }
            
        }
        
    }
    
}
