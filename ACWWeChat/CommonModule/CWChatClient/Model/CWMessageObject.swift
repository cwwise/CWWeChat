//
//  CWMessageContent.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

protocol CWMessageObject {
    
    /// 聊天消息
    weak var message: CWChatMessage? { get set }
    
    /// 消息类型
    var type: CWMessageType { get set}
    
}

