//
//  CWGroupManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 代理
public protocol CWGroupManagerDelegate {
    
}

public typealias CWGroupCompletion = (CWChatGroup?, CWChatError?) -> Void

/// 群管理
public protocol CWGroupManager {
    
    /// 添加代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addGroupDelegate(_ delegate: CWGroupManagerDelegate, delegateQueue: DispatchQueue)
    
    /// 删除代理
    ///
    /// - Parameter delegate: 代理
    func removeGroupDelegate(_ delegate: CWGroupManagerDelegate)
    
    func fetchJoinGroups()
    
    func createGroup(title: String,
                     invitees: [String],
                     message: String,
                     setting: CWChatGroupOptions,
                     completion: CWGroupCompletion?)
}

