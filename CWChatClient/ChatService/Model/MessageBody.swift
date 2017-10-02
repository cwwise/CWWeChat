//
//  MessageBody.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public class MessageBody: Codable {
    /// 消息类型
    public private(set) var type: MessageType
    
    init() {
       type = .none 
    }
}
