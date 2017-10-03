//
//  ContactManagerProtocol.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public protocol ContactManagerDelegate {
    
}

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
    
    
    
    
}
