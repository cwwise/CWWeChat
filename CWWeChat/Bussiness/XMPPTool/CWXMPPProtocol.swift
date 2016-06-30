//
//  CWXMPPProtocol.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

protocol CWXMPPProtocol {
    
}

public enum CWUserStatus: String {
    case None = "none"
    case Online = "available"
    case Offline = "unavailable"
}

/**
 XMPP当前连接状态
 
 - None:         默认状态
 - Error:        连接错误状态
 - Connected:    已经连接
 - Connecting:   连接中
 - Disconnected: 未连接
 */
public enum CWXMPPStatus {
    case None
    case Error
    case Connected
    case Connecting
    case Disconnected
}

/**
 配置xmpp账户信息
 */
protocol CWXMPPManagerDataSource: NSObjectProtocol {
    
    var serverAddress: String {get}
    var userName: String {get}
    var password: String {get}

}


