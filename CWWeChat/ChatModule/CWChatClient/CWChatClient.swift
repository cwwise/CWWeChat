//
//  CWChatClient.swift
//  CWWeChat
//
//  Created by chenwei on 2017/2/12.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation

/// 聊天核心单例
public class CWChatClient: NSObject {
    /// 单例
    public static let share = CWChatClient()
    /// 版本
    private(set) var version: String
    /// 聊天配置信息
    private(set) var options: CWChatClientOptions
    /// login
    private(set) var loginManager: CWLoginManager
    /// 聊天模块
    private(set) var chatManager: CWChatManager
    /// 好友模块
    private(set) var contactManager: CWContactManager
    /// 群组模块
    private(set) var groupManager: CWGroupManager
    /// 聊天室模块
    private(set) var chatroomManager: CWChatroomManager
    
    public var userId: String {
        return self.loginManager.currentAccount
    }
    
    private override init() {
        version = "0.0.1"
        
        let xmppManager = CWXMPPManager()
        self.loginManager = xmppManager
        
        let chatManager = CWChatService(dispatchQueue: DispatchQueue.global())!
        let _ = chatManager.activate(xmppManager.xmppStream)
        self.chatManager = chatManager
        
        let contactManager = CWContactService(dispatchQueue: DispatchQueue.global())!
        let _ = contactManager.activate(xmppManager.xmppStream)
        self.contactManager = contactManager
        
        let groupManager = CWGroupService(dispatchQueue: DispatchQueue.global())!
        let _ = groupManager.activate(xmppManager.xmppStream)
        self.groupManager = groupManager
        
        let chatroomManager = CWChatroomService(dispatchQueue: DispatchQueue.global())!
        let _ = chatroomManager.activate(xmppManager.xmppStream)
        self.chatroomManager = chatroomManager
        
        self.options = CWChatClientOptions(host: "cwwise.com", domain: "cwwise.com")
        super.init()
    }
    
    /// 初始化聊天信息
    ///
    /// - Parameter options: 配置项
    public func initialize(with options: CWChatClientOptions) {
        self.options = options
        let xmppManager = self.loginManager as! CWXMPPManager
        xmppManager.options = options
    }
}

public extension CWChatClient {
    
    var userFilePath: String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = "\(documentPath)/\(self.options.domain)/\(self.userId)"
        return path
    }
    
}

