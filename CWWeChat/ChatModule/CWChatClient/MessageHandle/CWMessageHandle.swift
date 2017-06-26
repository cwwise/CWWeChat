//
//  CWMessageHandle.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

protocol CWMessageHandleDelegate: NSObjectProtocol {
    func handMessageComplete(message: CWMessage)
}

class CWMessageHandle: NSObject, CWMessageHandleProtocol {

    weak var delegate: CWMessageHandleDelegate?
    
    weak var nextMessageHandle: CWMessageHandleProtocol?

    @discardableResult func handleMessage(message: XMPPMessage) -> Bool {
        // 如果下一个响应者存在 并且消息不是错误消息
        guard let handle = self.nextMessageHandle else {
            return false
        }
        return handle.handleMessage(message: message)
    }
}
