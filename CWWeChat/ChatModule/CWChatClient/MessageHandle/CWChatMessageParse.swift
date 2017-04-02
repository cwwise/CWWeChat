//
//  CWChatMessageParse.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

/// 消息解析
class CWChatMessageParse: XMPPModule {

    lazy var messageHandle: CWMessageHandle = {
        let messageHandle = CWMessageHandle()
        messageHandle.delegate = self
        messageHandle.nextMessageHandle = self.chatMessageHandle
        return messageHandle
    }()
    
    var chatMessageHandle: CWChatMessageHandle = {
       let chatMessageHandle = CWChatMessageHandle()
        return chatMessageHandle
    }()

    
    func registerLocalNotification(with message: CWChatMessage) {
        
        
        
        
    }
}

// MARK: - XMPPStreamDelegate
extension CWChatMessageParse: XMPPStreamDelegate {
    
    /**
     <message xmlns="jabber:client" from="chenwei@hellochatim.p1.im/wei的MacBook Pro" to="haohao@hellochatim.p1.im/ios" type="chat" id="59D68F07-854E-4D5C-8E1F-63350E6C5CB1">
     <body>chenwei</body>
     </message>
     */
    // 收到消息
    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        
        if UIApplication.shared.applicationState == .background {
            
            
        } else {
            
            
        }
        
        log.debug(message)
        
        _ = messageHandle.handleMessage(message: message)
        
    }
    
}


// MARK: - CWMessageHandleDelegate
extension CWChatMessageParse: CWMessageHandleDelegate {
    
    func handMessageComplete(message: CWChatMessage) {
        
        // 先保存消息
        
        
        // 处理事件
        //检查delegate 是否存在，存在就执行方法
        guard let multicastDelegate = self.value(forKey: "multicastDelegate") as? GCDMulticastDelegate else {
            return
        }
        
        ///遍历出所有的delegate
        let delegateEnumerator = multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
    
        while delegateEnumerator?.getNextDelegate(&delegate, delegateQueue: &queue) != nil {
            //执行Delegate的方法
            if let delegate = delegate as? CWChatManagerDelegate {
                queue?.sync {
                    delegate.messagesDidReceive(message)
                }
            }
        }
        
    }
    
}
