//
//  ChatClientOptions.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public class ChatClientOptions: NSObject {

    public static var `default`: ChatClientOptions = {
        let options = ChatClientOptions(host: "cwwise.com", domain: "cwwise.com")
        return options
    }()
    
    /// XMPP服务器 ip地址 默认为本地localhost
    public var host: String
    /// 端口号
    public var port: UInt16 = 5222
    /// XMPP聊天 域
    public var domain: String
    /// 来源 app iOS 安卓等等
    public var resource: String
    
    init(host: String, domain: String) {
        self.host = host
        self.domain = domain
        self.resource = "ios"
        super.init()
    }
    
}
