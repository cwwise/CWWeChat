//
//  CWMessageTransmitter.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

///发送消息等待时间
let sendMessageTimeoutInterval: TimeInterval = 30

/// 发送消息
class CWMessageTransmitter: XMPPModule {
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
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
        log.debug(message)
        // 发送消息
        var receipte: XMPPElementReceipt?
        xmppStream.send(message, andGet: &receipte)
        guard let elementReceipte = receipte else {
            return
        }
        // 返回结果
        let _ = elementReceipte.wait(sendMessageTimeoutInterval)
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
        let domain = CWChatClient.share.options.domain
        return name + "@" + domain
    }
    
}


