//
//  ContactManagerProtocol.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public enum UserInfoUpdateTag: String {
    // 昵称
    case nickName
    // 头像
    case avatar
    // 签名
    case sign
    // email
    case email
    // 电话
    case phone
}

/// 好友相关的回调
public protocol ContactManagerDelegate {
    /// 用户信息修改回调
    func onUserInfoChanged(user: User)
}

public typealias ContactCompletion = ([User], ChatClientError?) -> Void

public protocol ContactManager {
    
    /// 添加代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addContactDelegate(_ delegate: ContactManagerDelegate, delegateQueue: DispatchQueue)
    
    /// 删除代理
    ///
    /// - Parameter delegate: 代理
    func removeContactDelegate(_ delegate: ContactManagerDelegate)
    
    func updateMyUserInfo(_ userInfo: [UserInfoUpdateTag: String])
    
    func userInfo(with userId: String) -> User
}
