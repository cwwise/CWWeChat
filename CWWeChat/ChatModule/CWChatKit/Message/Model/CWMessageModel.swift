//
//  CWMessageModel.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/15.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

public enum CMessagePlayStatus {
    case none
    case playing
    case played
}

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
    
    public var sendStatus: CWMessageSendStatus {
        return message.sendStatus
    }
    
    public var targetId: String {
        return message.targetId
    }
    
    public var senderId: String {
        return message.senderId!
    }
    
    public var transportProgress: Float = 0
    
    public var playStatus: CMessagePlayStatus = .none

    // 文字(还待完善)
    public var textLayout: YYTextLayout?
    
    // 图片
    
    // 语音
    
    // 位置
    
    // 消息
    
    
    /// 是否显示时间
    public var showTime: Bool = false
    /// 是否显示用户名 
    public var showUsername: Bool = false
    
    public init(message: CWMessage) {
        self.message = message
        
        super.init()
    }
    
    
    
    
}

extension CWMessageModel {
    
}


// 优化

