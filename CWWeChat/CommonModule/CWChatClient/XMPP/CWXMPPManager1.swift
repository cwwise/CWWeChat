//
//  CWXMPPManager.swift
//  CWWeChat
//
//  Created by chenwei on 2017/2/12.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

// xmpp管理实例
class CWXMPPManager1: NSObject {
    
    private(set) var version: String
    private(set) var options: CWChatClientOptions!
    
    private override init() {
        version = "0.0.1"
        super.init()
    }
    
    
    /// 初始化聊天信息
    ///
    /// - Parameter options: 配置项
    func initializeChatClient(options: CWChatClientOptions) {
        self.options = options
        
    }
    
    
}
