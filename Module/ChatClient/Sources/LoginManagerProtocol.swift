//
//  LoginManager.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public typealias LoginHandler = (String?, ChatClientError?) -> Void

public protocol LoginManagerDelegate: class {
    /// 强制退出 密码修改 其他设备登录
    func userAccountDidForceLogout()
    
    /// 登录之后 会调用登录成功或者登录失败
    func loginSuccess()
    
    /// 登录失败
    ///
    /// - Parameter error: 失败原因
    func loginFailed(error: ChatClientError)
}

/// 登录管理
public protocol LoginManager: class {
    /// 是否连接
    var isConnented: Bool { get }
    /// 是否登录成功
    var isLogined: Bool { get }
    /// 当前登录用户
    var username: String { get }

    func login(username: String, password: String, completion: LoginHandler?)
    
    func register(username: String, password: String, completion: LoginHandler?)

    func addDelegate(_ delegate: LoginManagerDelegate)
    
    func removeDelegate(_ delegate: LoginManagerDelegate)
    
    func logout()
}
