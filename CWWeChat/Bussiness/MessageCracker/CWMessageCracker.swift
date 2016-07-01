//
//  CWMessageCracker.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import MMXXMPPFramework

/**
 *  收到新的消息
 */
protocol CWMessageCrackerDelegate: NSObjectProtocol {
    func receiveNewMessage(message: CWMessageModel)
}

/**
 消息接收处理类
 
 */
class CWMessageCracker: XMPPModule {
    
    class func shareMessageCracker() -> CWMessageCracker {
        return CWXMPPManager.shareXMPPManager.messageCracker
    }
    
    /// 消息处理
    lazy var messagehandle: CWChatMessageHandle = {
       let messagehandle = CWChatMessageHandle()
        messagehandle.delegate = self
        return messagehandle
    }()
    
    override init!(dispatchQueue queue: dispatch_queue_t!) {
        super.init(dispatchQueue: queue)
    }
    
    override init!() {
        super.init()
    }
}

extension CWMessageCracker: XMPPStreamDelegate {
    
    /**
     <message xmlns="jabber:client" from="chenwei@chatimswift.com/chenweideMacBook-Pro" to="tom@chatimswift.com/weiweideMacBook-Simulator" type="chat" id="purple38f1c379">
     <active xmlns="http://jabber.org/protocol/chatstates"></active>
     <body>12321</body>
     </message>
     */
    /**
     收到消息 并处理
     */
    func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
        //如果是聊天消息
        if message.isChatMessage() {
            
            CWLogDebug(message.description)
            if message.isChatMessageWithBody() == false {
                return
            }
            
            let cwMessage = CWXMPPMessage(message: message)
            //处理消息
            messagehandle.handleMessage(cwMessage)
            
        }
        
    }
    
    ///收到错误消息
    func xmppStream(sender: XMPPStream!, didReceiveError error: DDXMLElement!) {
        
        
        
    }
}

// MARK: - CWMessageHandleProtocol
extension CWMessageCracker: CWMessageHandleProtocol {
    
    ///消息处理结果
    func handleResult(handle: CWBaseMessageHandle, message: CWMessageModel, isDelay: Bool) {
       
        //先处理消息
        //如果不在聊天界面，则播放声音和震动
        if !inspectChatViewControllerFront() {
            CWLogDebug("聊天界面--震动")
            CWPlayMessageAudio.playSoundEffect("receivemsg.caf")
        }
        
        //检查delegate 是否存在，存在就执行方法
        guard let multicastDelegate = self.valueForKey("multicastDelegate") as? GCDMulticastDelegate else {
            return
        }
        
        ///遍历出所有的delegate
        let delegateEnumerator = multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: dispatch_queue_t?
        
        while delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue) {
            //执行Delegate的方法
            if let delegate = delegate as? CWBaseMessageViewController {
                
                dispatch_async(dispatch_get_main_queue(), { 
                    delegate.receiveNewMessage(message)
                })
                
            }
        }
    }
    
    /**
      检查当前是否在聊天界面
     
       * 通过delegate来检查，是根据实际情况想的。
       * 或者通过 UIApplication来获取前台的ViewController进行判断
     
     - returns: YES则代表 聊天详情界面在前台
     */
    func inspectChatViewControllerFront() -> Bool {
        
        //检查delegate 是否存在，存在就执行方法
        guard let multicastDelegate = self.valueForKey("multicastDelegate") as? GCDMulticastDelegate else {
            return false
        }
        
        //遍历出所有的delegate，查看
        let delegateEnumerator = multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: dispatch_queue_t?
        //通过GCDMulticastDelegate类 来检查。
        return delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue, ofClass: CWChatViewController.self)
    }
}
