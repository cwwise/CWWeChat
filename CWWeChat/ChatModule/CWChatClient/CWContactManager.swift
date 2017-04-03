//
//  CWContactManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 好友相关的回调
public protocol CWContactManagerDelegate {
    
}

public typealias CWContactCompletion = (_ contacts: [CWChatUser], _ error: NSError?) -> Void


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
    func fetchContactsFromServer(completion: CWContactCompletion)
    
    
}
