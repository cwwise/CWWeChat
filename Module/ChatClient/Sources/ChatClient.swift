//
//  ChatClient.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import SwiftyBeaver

@_exported import SwiftyJSON

/// 打印
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

    public var groupManager: GroupManager {
        return groupService
    }

    /// 用户名（username@wanzhao.com）
    public var username: String {
        return self.loginManager.currentAccount
    }
    
    // 内部使用
    var chatService: ChatService
    
    var contactService: ContactService
    
    var groupService: GroupService
    
    var xmppManager: XMPPManager
    
    private init() {
        version = "0.0.1"
        
        options = ChatClientOptions.default

        xmppManager = XMPPManager()
        xmppManager.options = options
        
        let queue = DispatchQueue(label: "com.chatclient.cwwise")
        chatService = ChatService()
//        chatService.activate(xmppManager.xmppStream)
        xmppManager.xmppStream.addDelegate(chatService, delegateQueue: queue)
        
        
        contactService = ContactService(dispatchQueue: queue)
        contactService.activate(xmppManager.xmppStream)
        
        groupService = GroupService(dispatchQueue: queue)
        groupService.activate(xmppManager.xmppStream)
    }
    
    /// 初始化聊天信息
    ///
    /// - Parameter options: 配置项
    public func initialize(with options: ChatClientOptions) {
        self.options = options
        xmppManager.options = options
    }
}

// MARK: - Helper
extension ChatClient {
    
    func registerNotification() {
        /// 应用将要销毁
        let terminate = NSNotification.Name.UIApplicationWillTerminate
        NotificationCenter.default.addObserver(forName: terminate, object: nil, queue: OperationQueue
            .main) { (noti) in
                
                
                
                
                
        }
        
        /// 系统时间变化
        let timeChange = NSNotification.Name.UIApplicationSignificantTimeChange
        NotificationCenter.default.addObserver(forName: timeChange, object: nil, queue: OperationQueue.main) { (noti) in
            
        }
    }
    
    /// 移除通知
    func removeNotifacation() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
