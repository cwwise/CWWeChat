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
    public var type: MessageType {
        return .text
    }
    /// 文本内容
    public var text: String
    
    // 内部使用 
    init() {
        self.text = ""
    }
    
    public init(text: String) {
        self.text = text
    }
    
    public func messageEncode() -> String {
        return text
    }
    
    public func messageDecode(string: String) {
        self.text = string
    }
    
    public var description: String {
        return text
    }
}
