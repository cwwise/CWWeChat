//
//  CWMessageHandleProtocol.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import XMPPFramework

protocol CWMessageHandleProtocol: NSObjectProtocol {
    
    /// 下一个响应者
    weak var nextMessageHandle: CWMessageHandleProtocol? {set get}
    
    /// 处理消息
    ///
    /// - Parameter message: XMPPMessage消息
    @discardableResult func handleMessage(message: XMPPMessage) -> Bool
}
