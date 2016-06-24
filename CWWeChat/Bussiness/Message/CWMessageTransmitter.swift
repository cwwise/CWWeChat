//
//  CWMessageTransmitter.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import MMXXMPPFramework


///发送消息等待时间
let sendMessageTimeoutInterval: NSTimeInterval = 30

protocol CWMessageTransmitterDelegate:class {
    //消息发送结果
    func messageSendCallback(result:Bool)
}

/**
 消息发送的类
 
 * 生成各种消息的XML
 * 发送消息
 
 */
class CWMessageTransmitter: XMPPModule {

    /// 不算是单例，单例 只在manager中，方便管理，还不知道是不是最佳方法
    class func shareMessageTransmitter() -> CWMessageTransmitter {
        return CWXMPPManager.shareXMPPManager.messageTransmitter
    }
    
    override init!(dispatchQueue queue: dispatch_queue_t!) {
        super.init(dispatchQueue: queue)
    }
    
    override init!() {
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
    func sendMessage(content:String, toId:String, messageId:String, type:Int = 1) -> Bool {

        let messageElement = self.messageElement(content, to: toId, messageId: messageId)
        
        var receipte: XMPPElementReceipt?
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
    func messageElement(body: String, to: String, messageId: String) -> XMPPMessage {
        //消息内容
        let message = XMPPMessage(type: "chat", elementID: messageId)
        message.addAttributeWithName("to", stringValue: to)
//        message.addReceiptRequest()
        message.addBody(body)
        print(message)
        return XMPPMessage(fromElement: message)
    }
    
    
}
