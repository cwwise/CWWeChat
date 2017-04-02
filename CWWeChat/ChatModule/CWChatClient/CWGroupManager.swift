//
//  CWGroupManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 代理
protocol CWGroupManagerDelegate {
    
}

/// 群管理
protocol CWGroupManager {
    
    /// 添加代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addDelegate(_ delegate: CWGroupManagerDelegate, delegateQueue: DispatchQueue)
    
    /// 删除代理
    ///
    /// - Parameter delegate: 代理
    func removeDelegate(_ delegate: CWGroupManagerDelegate)
    
}

