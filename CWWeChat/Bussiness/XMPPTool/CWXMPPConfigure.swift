//
//  CWXMPPConfigure.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

/// xmpp配置信息
class CWXMPPConfigure: NSObject {
    
    class func shareXMPPConfigure() -> CWXMPPConfigure {
        let configure = CWXMPPConfigure()
        return configure
    }
    
    var xmppDomain: String
    var hostName: String
    var hostPort: UInt16
    
    override init() {
//        xmppDomain = "121.41.129.248"
//        hostName = "121.41.129.248"
        xmppDomain = "chatimswift.com"
        hostName = "127.0.0.1"
        hostPort = 5222
        super.init()
    }
}
