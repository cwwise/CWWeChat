//
//  ChatClient.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

public class ChatClient {
    
    public static let share = ChatClient()
    /// 版本
    public private(set) var version: String
    
    public private(set) var options: ChatClientOptions
    
    /// login    
    public var loginManager: LoginManager {
        return xmppManager
    }

    public var chatManager: ChatManager {
        return chatService
    }
    
    public var contactManager: ContactManager {
        return contactService
    }

    public var currentAccount: String {
        return self.loginManager.currentAccount
    }
    
    // 内部使用
    var chatService: ChatService
    
    var contactService: ContactService
    
    var xmppManager: XMPPManager
    
    private init() {
        version = "0.0.1"
        
        options = ChatClientOptions.default

        xmppManager = XMPPManager()
        xmppManager.options = options
        
        let queue = DispatchQueue.global()
        chatService = ChatService(dispatchQueue: queue)
        chatService.activate(xmppManager.xmppStream)
        
        contactService = ContactService(dispatchQueue: queue)
        contactService.activate(xmppManager.xmppStream)
    }
    
    /// 初始化聊天信息
    ///
    /// - Parameter options: 配置项
    public func initialize(with options: ChatClientOptions) {
        self.options = options
        xmppManager.options = options
    }
}
