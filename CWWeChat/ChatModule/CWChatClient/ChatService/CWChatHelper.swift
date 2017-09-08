//
//  CWChatHelper.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

func chatJID(with userId: String) -> XMPPJID {
    let domain = CWChatClient.share.options.domain
    let resource = CWChatClient.share.options.resource
    let jid = XMPPJID(user: userId, domain: domain, resource: resource)!
    return jid
}

public extension XMPPModule {
    // 执行代理方法
    public func executeDelegateSelector(_ action: ((AnyObject?, DispatchQueue?) -> Void)) {
        // 处理事件
        // 检查delegate 是否存在，存在就执行方法
        guard let multicastDelegate = self.value(forKey: "multicastDelegate") as? GCDMulticastDelegate else {
            return
        }
        ///遍历出所有的delegate
        let delegateEnumerator = multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        
        while delegateEnumerator?.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            action(delegate, queue)
        }
    }
}

