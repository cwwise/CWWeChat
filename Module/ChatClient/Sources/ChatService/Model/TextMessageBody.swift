//
//  TextMessageBody.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public class TextMessageBody: MessageBody {
    /// 消息体类型
    public override var type: MessageType {
        return .text
    }
    /// 文本内容
    public var text: String
    
    public init(text: String) {
        self.text = text
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
