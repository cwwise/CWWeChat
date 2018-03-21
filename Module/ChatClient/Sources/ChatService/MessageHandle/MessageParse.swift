//
//  MessageParse.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import XMPPFramework

protocol MessageParseDelegate: class {
    func successParse(message: Message)
}

class MessageParse {
    
    weak var delegate: MessageParseDelegate?
    
    private lazy var messageHandle: MessageHandle = {
        let messageHandle = MessageHandle()
        messageHandle.delegate = self
        messageHandle.nextMessageHandle = self.chatMessageHandle
        return messageHandle
    }()
    
    private lazy var chatMessageHandle: ChatMessageHandle = {
        let chatMessageHandle = ChatMessageHandle()
        chatMessageHandle.delegate = self
        return chatMessageHandle
    }()
    
    func handle(message: XMPPMessage) {
        chatMessageHandle.handleMessage(message)
    }
}

// MARK: - CWMessageHandleDelegate
extension MessageParse: MessageHandleDelegate {
    
    func handMessageComplete(message: Message) {
        self.delegate?.successParse(message: message)
    }
    
}
