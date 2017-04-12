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
    
    lazy var chatMessageHandle: CWChatMessageHandle = {
       let chatMessageHandle = CWChatMessageHandle()
        chatMessageHandle.delegate = self
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
        
        log.verbose(message)
        messageHandle.handleMessage(message: message)
    }
    

}


// MARK: - CWMessageHandleDelegate
extension CWChatMessageParse: CWMessageHandleDelegate {
    
    func handMessageComplete(message: CWChatMessage) {
        // 先保存消息
        let chatService = CWChatClient.share.chatManager as! CWChatService
        chatService.receiveMessage(message)
        

        
    }
    
}
