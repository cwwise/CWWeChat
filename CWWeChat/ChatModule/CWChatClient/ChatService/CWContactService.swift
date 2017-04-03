//
//  CWContactService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

/// 联系人模块
class CWContactService: XMPPModule {

    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
    }

}


extension CWContactService: CWContactManager {

    /// 添加代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addContactDelegate(_ delegate: CWContactManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    /// 删除代理
    ///
    /// - Parameter delegate: 代理
    func removeContactDelegate(_ delegate: CWContactManagerDelegate) {
        removeDelegate(delegate)
    }
    
    // MARK: 获取好友
    func fetchContactsFromServer(completion: CWContactCompletion) {
        
        
        
    }
    

}
