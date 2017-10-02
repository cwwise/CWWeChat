//
//  LoginManager.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public typealias LoginHandler = (String?, ChatClientError?) -> Void

public enum LoginStep: Int {
    case linking
    case linkS
    case logining
    case loginfailed
}

public protocol LoginManagerDelegate: class {
    func onLogin(setp: LoginStep)
}

/// 登录管理
public protocol LoginManager: class {
    /// 是否连接
    var isConnented: Bool { get }
    /// 是否登录成功
    var isLogined: Bool { get }
    /// 当前登录用户
    var currentAccount: String { get }

    func login(username: String, password: String, completion: LoginHandler?)
    
    func register(username: String, password: String, completion: LoginHandler?)
 
    func addLoginDelegate(_ delegate: LoginManagerDelegate)
    
    func removeLoginDelegate(_ delegate: LoginManagerDelegate)
    
    func logout()
}
