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
class CWMessageTransmitter: NSObject {
    
    /// xmpp实例
    private var xmppStream: XMPPStream {
        return CWChatXMPPManager.share.xmppStream
    }
    
    func sendMessage(content: String, targetId: String, messageId: String ,type: Int = 0) -> Bool {
        // 生成消息
        let messageElement = self.messageElement(body: content, to: targetId, messageId: messageId)
        // 发送消息
        var receipte: XMPPElementReceipt?
        self.xmppStream.send(messageElement, andGet: &receipte)
        guard let elementReceipte = receipte else {
            return false
        }
        // 返回结果
        let result = elementReceipte.wait(sendMessageTimeoutInterval)
        return result
    }
    
    
    func messageElement(body: String, to: String, messageId: String, type:Int = 1, expand: String? = nil) -> XMPPMessage? {

        let message = XMPPMessage(type: "chat", elementID: messageId)
        message?.addAttribute(withName: "to", stringValue: chatJidString(to))
        
        let bodyElement = DDXMLElement.element(withName: "body", stringValue: body) as! DDXMLElement
        bodyElement.addAttribute(withName: "type", integerValue: type)

        message?.addChild(bodyElement)

        return message
    }

    
    func chatJidString(_ name: String) -> String {
        let domain = CWChatXMPPManager.share.options.chatDomain
        return name + "@" + domain
    }

    
}
