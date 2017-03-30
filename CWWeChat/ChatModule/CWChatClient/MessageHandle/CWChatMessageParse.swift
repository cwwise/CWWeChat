//
//  CWChatMessageParse.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

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

    
    // 收到消息
    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        
        if UIApplication.shared.applicationState == .background {
            
            
        } else {
            
            
        }
        
        _ = messageHandle.handleMessage(message: message)
        
    }
    
    func registerLocalNotification(with message: CWChatMessage) {
        
        
        
        
    }
    
    
}

// MARK: - CWMessageHandleDelegate
extension CWChatMessageParse: CWMessageHandleDelegate {
    
    func handMessageComplete(message: CWChatMessage) {
        
        // 先保存消息
        
        
    }
    
}
