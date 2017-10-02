//
//  MessageTransmitter.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import XMPPFramework

private let kSendMessageTimeoutInterval: TimeInterval = 30

class MessageTransmitter: NSObject {
    
    var xmppStream: XMPPStream {
        let manager = ChatClient.share.loginManager as! XMPPManager
        return manager.xmppStream
    }
    
    func sendMessage(content: String,
                     targetId: String,
                     messageId: String,
                     chatType:Int = 0, 
                     type: Int = 1) {
        // 生成消息
        let messageElement = self.messageElement(withBody: content,
                                                 to: targetId,
                                                 messageId: messageId,
                                                 type: type,
                                                 chatType: chatType)
        guard let message = messageElement else {
            return
        }
        // 发送消息
        var receipte: XMPPElementReceipt?
        xmppStream.send(message, andGet: &receipte)
        guard let elementReceipte = receipte else {
            return
        }
        // 返回结果
        let _ = elementReceipte.wait(kSendMessageTimeoutInterval)
    }
    
    func messageElement(withBody body: String, 
                        to: String, 
                        messageId: String,
                        type:Int = 1, 
                        chatType:Int = 0, 
                        expand: String? = nil) -> XMPPMessage? {
        
        let message: XMPPMessage?
        if chatType == 0 {
            message = XMPPMessage(type: "chat", elementID: messageId)
        } else {
            message = XMPPMessage(type: "groupchat", elementID: messageId)
        }
        message?.addAttribute(withName: "to", stringValue: chatJidString(withType: chatType, name: to))
        //  message?.addReceiptRequest()
        let bodyElement = DDXMLElement.element(withName: "body", stringValue: body) as! DDXMLElement
        bodyElement.addAttribute(withName: "msgtype", integerValue: type)
        
        message?.addChild(bodyElement)
        return message
    }
    
    
    func chatJidString(withType chatType:Int, name: String) -> String {
        if chatType == 1 {
            return name
        }
        let domain = ChatClient.share.options.domain
        return name + "@" + domain
    }
    
    
}
