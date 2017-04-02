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
        xmppDomain = "cwcoder.com"
        hostName = "www.cwcoder.com"
        hostPort = 5222
        super.init()
    }
}
