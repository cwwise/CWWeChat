//
//  CWChatClient.swift
//  CWWeChat
//
//  Created by chenwei on 2017/2/12.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 聊天核心单例
class CWChatClient: NSObject {
    
    /// 单例
    public static let share = CWChatClient()
    
    /// 版本
    private(set) var version: String
    
    /// 聊天配置信息
    private(set) var options: CWChatClientOptions!
    
    /// 聊天模块
//    private(set) var chatManager;
    
    
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
