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
class CWMessageParse: NSObject {

    lazy var messageHandle: CWMessageHandle = {
        let messageHandle = CWMessageHandle()
        messageHandle.delegate = self
        messageHandle.nextMessageHandle = self.chatMessageHandle
        return messageHandle
    }()
    
    lazy var chatMessageHandle: CWChatMessageHandle = {
       let chatMessageHandle = CWChatMessageHandle()
        chatMessageHandle.delegate = self
        return chatMessageHandle
    }()

    
    func registerLocalNotification(with message: CWMessage) {
        
        
        
        
    }
}

// MARK: - XMPPStreamDelegate
extension CWMessageParse: XMPPStreamDelegate {
    
    /**
     <message xmlns="jabber:client" from="chenwei@hellochatim.p1.im/wei的MacBook Pro" to="haohao@hellochatim.p1.im/ios" type="chat" id="59D68F07-854E-4D5C-8E1F-63350E6C5CB1">
     <body>chenwei</body>
     </message>
     */
    // 收到消息
    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        
        log.info(message)
        messageHandle.handleMessage(message: message)
        DispatchQueue.main.async {
            if UIApplication.shared.applicationState == .background {
                
                
            } else {
                
                
            }
        }
    }
}


// MARK: - CWMessageHandleDelegate
extension CWMessageParse: CWMessageHandleDelegate {
    
    func handMessageComplete(message: CWMessage) {
        // 先保存消息
        let chatService = CWChatClient.share.chatManager as! CWChatService
        chatService.receiveMessage(message)
        

        
    }
    
}
