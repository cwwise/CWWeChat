//
//  CWChatClientOptions.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/14.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation

// 配置信息
public class CWChatClientOptions: NSObject {
    
    /// 端口号
    var port: UInt16 = 5222
    /// XMPP服务器 ip地址 默认为本地localhost
    var host: String
    /// XMPP聊天 域
    var domain: String
    /// 来源 app iOS 安卓等等
    var resource: String
    
    init(host: String, domain: String) {
        self.host = host
        self.domain = domain
        self.resource = "ios"
        super.init()
    }
}
