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
    ///  是否自动登录
    var isAutoLogin: Bool = true
    
    
    /// 端口号
    var chatPort: UInt16 = 5222
    /// XMPP服务器 ip地址 默认为本地localhost
    var chatServer: String
    /// XMPP聊天 域
    var chatDomain: String
    /// 来源 app iOS 安卓等等
    var chatResource: String
    
    init(chatServer: String = "localhost", chatDomain: String) {
        self.chatDomain = chatDomain
        self.chatServer = chatServer
        self.chatResource = "ios"
        super.init()
    }
    
    convenience override init() {
        self.init(chatDomain: "")
    }
    
}
