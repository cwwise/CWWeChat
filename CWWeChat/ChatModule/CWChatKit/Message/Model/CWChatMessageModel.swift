//
//  CWChatMessageModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 消息model
class CWChatMessageModel: NSObject {

    /// 聊天消息
    var message: CWChatMessage
    
    /// 是否显示时间
    var showTime: Bool = false

    var messageFrame: CWChatMessageFrame!


    
    init(message: CWChatMessage) {
        self.message = message;
    }
    
    
}
