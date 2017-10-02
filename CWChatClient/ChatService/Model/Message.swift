//
//  Message.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

/// 消息方向
///
/// - send: 发送方
/// - receive: 接受方
public enum MessageDirection : Int {
    case send = 1
    case receive
}

/// 消息发送状态
///
/// - sending: 正在发送
/// - successed: 发送成功
/// - failed: 发送失败
public enum MessageSendStatus : Int {
    case sending
    case successed
    case failed
}

/// 消息类型
public enum MessageType: Int, Codable {
    case none               //未知消息
    case text               //文字
    case image              //图片
    case voice              //声音
    case video              //视频
    case file               //文件
    case location           //位置
    case emoticon           //表情
    case notification       //通知
}

public class Message: NSObject {
    /// 会话id
    public var conversationId: String
    /// 会话类型
    public var chatType: ChatType
    /// 消息类型
    public var messageType: MessageType {
        return self.body.type
    }
    /// 消息来源
    public var from: String
    /// 消息唯一id
    public var messageId: String
    /// 消息发送方
    public var direction: MessageDirection
    /// 发送状态
    public var sendStatus: MessageSendStatus
    /// 消息体
    public var body: MessageBody
    /// 消息发送时间
    public var timestamp: TimeInterval
    /// 消息扩展
    public var extra: [String: AnyObject]?
    
    /// 实例化
    ///
    /// - Parameters:
    ///   - conversationId: 会话id
    ///   - from: 消息发起
    ///   - body: body体
    public init(conversationId: String,
                from: String,
                body: MessageBody) {
        
        self.chatType = .single
        self.messageId = ChatClientUtil.messageId
        self.conversationId = conversationId
        self.body = body
        self.sendStatus = .sending
        self.direction = .send
        self.timestamp = ChatClientUtil.currentTime
        self.from = from
        super.init()
    }
}
