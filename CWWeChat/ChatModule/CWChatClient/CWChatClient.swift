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
public enum CWXMPPStatus: String {
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

/// 聊天核心单例
public class CWChatClient: NSObject {
    /// 单例
    public static let share = CWChatClient()
    /// 版本
    private(set) var version: String
    /// 聊天配置信息
    private(set) var options = CWChatClientOptions()
    /// XMPP实例
    private var xmppManager = CWChatXMPPManager.share
    /// 当前登陆用户
    private(set) var userId: String!
    /// 聊天模块
    lazy private(set) var chatManager: CWChatManager = CWChatService(dispatchQueue: DispatchQueue.global())
    /// 是否连接服务器
    private(set) var isConnected: Bool = false
    /// 用户是否已登录
    private(set) var isLoggedIn: Bool = false
    
    private override init() {
        version = "0.0.1"
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
        
    }
    
    public func register(username: String,
                         password: String,
                         completion: CWClientCompletion? = nil) {
        userId = username
        xmppManager.loginServer(with: username,
                                password: password,
                                isLogin: false,
                                completion: completion)
        
    }
    
    
}
