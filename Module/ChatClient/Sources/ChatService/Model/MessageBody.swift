//
//  MessageBody.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

/**
 这个地方处理待完善 
 */
public protocol MessageCodable {
    /// 保存到数据库中的字段
    func messageEncode() -> String
    
    /// 解析数据库中的数据
    ///
    /// - Parameter content: 数据库中的内容
    func messageDecode(string: String)
}

public protocol MessageBody: MessageCodable, CustomStringConvertible  {
    /// 消息类型
    var type: MessageType { get }
}
