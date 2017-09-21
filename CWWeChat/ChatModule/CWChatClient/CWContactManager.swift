//
//  CWContactManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public enum CWUserInfoUpdateTag: String {
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
public protocol CWContactManagerDelegate {
    /// 用户信息修改回调
    func onUserInfoChanged(user: CWUser)
}

public typealias CWContactCompletion = (_ contacts: [CWUser], _ error: CWChatError?) -> Void

public typealias CWAddContactCompletion = (_ contact: CWUser, _ error: CWChatError?) -> Void

public protocol CWContactManager {
    /// 添加代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addContactDelegate(_ delegate: CWContactManagerDelegate, delegateQueue: DispatchQueue)
    
    /// 删除代理
    ///
    /// - Parameter delegate: 代理
    func removeContactDelegate(_ delegate: CWContactManagerDelegate)
    
    // MARK: 获取好友
    func fetchContactsFromServer(completion: CWContactCompletion?)
    
    func addContact(_ contact: CWUser, message: String, completion: CWAddContactCompletion?)
    
    func updateMyUserInfo(_ userInfo: [CWUserInfoUpdateTag: String])
    
    func userInfo(with userId: String) -> CWUser
}
