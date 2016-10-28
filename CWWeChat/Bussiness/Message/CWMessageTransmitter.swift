//
//  CWMessageTransmitter.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import XMPPFramework

///发送消息等待时间
let sendMessageTimeoutInterval: TimeInterval = 30

/**
 消息发送的类
 
 * 生成各种消息的XML
 * 发送消息
 */
class CWMessageTransmitter: NSObject {

    fileprivate var xmppStream: XMPPStream {
        return CWXMPPManager.shareXMPPManager.xmppStream
    }
    
    override init() {
        super.init()
    }
    
    /**
     发送消息
     
     - parameter content:   消息内容
     - parameter toId:      发送到对方的JID
     - parameter messageId: 消息Id
     - parameter type:      消息类型
     
     - returns: 发送消息的结果
     */
    func sendMessage(_ content:String, toId:String, messageId:String, type:Int = 1, expand: String? = nil) -> Bool {
        
        let messageElement = self.messageElement(content, to: toId, messageId: messageId, type: type, expand: expand)
        
        var receipte: XMPPElementReceipt?
        CWPlayMessageAudio.playSoundEffect("sendmsg.caf")
        self.xmppStream.sendElement(messageElement, andGetReceipt: &receipte)
        guard let elementReceipte = receipte else {
            return false
        }
        let result = elementReceipte.wait(sendMessageTimeoutInterval)
        return result
    }
    
    /**
     组装XMPPMessage消息体
     
     - parameter message:   消息内容
     - parameter to:        发送到对方的JID
     - parameter messageId: 消息Id
     
     - returns: 消息XMPPMessage的实体
     */
    func messageElement(_ body: String, to: String, messageId: String, type:Int = 1, expand: String? = nil) -> XMPPMessage {
        //消息内容
        let message = XMPPMessage(type: "chat", elementID: messageId)
        message.addAttributeWithName("to", stringValue: chatJidString(to))
//        message.addReceiptRequest()
        
        //有两种方式添加消息类型
        //第一种是在消息body中添加type的属性。
        let bodyElement = DDXMLElement.elementWithName("body", stringValue: body) as! DDXMLElement
        bodyElement.addAttributeWithName("type", integerValue: type)
        if let expand = expand {
            bodyElement.addAttributeWithName("expand", stringValue: expand)
        }
        
        message.addChild(bodyElement)
        
        //第二种根据消息不同在消息body添加前缀,在CWMessageDispatchOperation发送中添加。
//        message.addBody(body)
        CWLogDebug(message.description)
        return XMPPMessage(fromElement: message)
    }
    
    
    //统一通过方法转换获取JID
    func chatJidString(_ name: String) -> String {
        return name + "@" + CWXMPPConfigure.shareXMPPConfigure().xmppDomain
    }
    
    
}
