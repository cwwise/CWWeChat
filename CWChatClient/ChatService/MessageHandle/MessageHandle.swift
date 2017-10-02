//
//  MessageHandle.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import XMPPFramework

protocol MessageHandleDelegate: class {
    func handMessageComplete(message: Message)
}

class MessageHandle: NSObject {

    weak var delegate: MessageHandleDelegate?
    
    weak var nextMessageHandle: MessageHandle?
    
    @discardableResult func handleMessage(message: XMPPMessage) -> Bool {
        // 如果下一个响应者存在 并且消息不是错误消息
        guard let handle = self.nextMessageHandle else {
            return false
        }
        return handle.handleMessage(message: message)
    }
    
}
