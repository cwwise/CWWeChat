//
//  CWChatClient.swift
//  CWWeChat
//
//  Created by chenwei on 2017/2/12.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit


/**
 chat当前连接状态
 
 - None:         默认状态
 - Error:        连接错误状态
 - Connected:    已经连接
 - Connecting:   连接中
 - Disconnected: 未连接
 */
public enum CWChatClientStatus: String {
    case none = ""
    case error = "连接错误"
    case connected = "已经连接..."
    case connecting = "正在连接"
    case disconnected = "未连接"
}

public protocol CWChatClientDelegate {
    // 当前登录账号在其它设备登录时会接收到此回调
    func userAccountDidLoginFromOtherDevice()
}

public extension CWChatClientDelegate {
    func userAccountDidLoginFromOtherDevice() {}
}

public typealias CWClientCompletion = (String?, CWChatError?) -> Void
// 路径
public let kChatUserImagePath = "\(CWChatClient.share.userFilePath)/image/"

/// 聊天核心单例
public class CWChatClient: NSObject {
    /// 单例
    public static let share = CWChatClient()
    /// 版本
    private(set) var version: String
    /// 聊天配置信息
    private(set) var options = CWChatClientOptions()
    /// 当前登陆用户
    private(set) var userId: String!
    /// 聊天模块
    private(set) var chatManager: CWChatManager
    /// 好友模块
    private(set) var contactManager: CWContactManager
    /// 群组模块
    private(set) var groupManager: CWGroupManager
    /// 聊天室模块
    private(set) var chatroomManager: CWChatroomManager

    
    /// 是否连接服务器
    private(set) var isConnected: Bool = false
    /// 用户是否已登录
    private(set) var isLoggedIn: Bool = false
    
    /// XMPP实例
    private var xmppManager = CWChatXMPPManager.share
    
    private override init() {
        version = "0.0.1"
        chatManager = CWChatService(dispatchQueue: DispatchQueue.global()) 
        contactManager = CWContactService(dispatchQueue: DispatchQueue.global())
        groupManager = CWGroupServic(dispatchQueue: DispatchQueue.global())
        chatroomManager = CWChatroomService(dispatchQueue: DispatchQueue.global())
        super.init()
    }
    
    /// 初始化聊天信息
    ///
    /// - Parameter options: 配置项
    public func initialize(with options: CWChatClientOptions) {
        self.options = options
        xmppManager.options = options
    }
    
    
    public func login(username: String,
                      password: String,
                      completion: CWClientCompletion? = nil) {
        userId = username
        xmppManager.loginServer(with: username, password: password, completion: completion)
        
        // 登陆成功之后
        initUser()
    }
    
    private func initUser() {

        
    }
    
    public func register(username: String,
                         password: String,
                         completion: CWClientCompletion? = nil) {

        xmppManager.loginServer(with: username,
                                password: password,
                                isLogin: false,
                                completion: completion)

    }
    
    
}

public extension CWChatClient {
    
    var userFilePath: String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = "\(documentPath)/cwchat/\(self.options.chatDomain)/\(self.userId!)"
        return path
    }
    
}

