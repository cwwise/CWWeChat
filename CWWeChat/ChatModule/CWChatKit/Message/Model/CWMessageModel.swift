//
//  CWMessageModel.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/15.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMessageModel: NSObject {
    
    private var message: CWMessage

    public var isSend: Bool {
        return message.direction == .send
    }
    
    public var messageBody: CWMessageBody {
        return message.messageBody
    }

    /// 消息类型
    public var messageType: CWMessageType {
        return message.messageBody.type
    }
    
    public var targetId: String {
        return message.targetId
    }
    
    public var senderId: String {
        return message.senderId!
    }
    
    /// 是否显示时间
    public var showTime: Bool = false
    /// 是否显示用户名 
    public var showUsername: Bool = false
    
    public init(message: CWMessage) {
        self.message = message
        
        super.init()
    }
    
}
