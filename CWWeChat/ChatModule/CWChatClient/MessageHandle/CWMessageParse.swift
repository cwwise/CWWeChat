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

    
    
}




// MARK: - CWMessageHandleDelegate
extension CWMessageParse: CWMessageHandleDelegate {
    
    func handMessageComplete(message: CWMessage) {
        // 先保存消息
        let chatService = CWChatClient.share.chatManager as! CWChatService
        chatService.receiveMessage(message)
        

        
    }
    
}
