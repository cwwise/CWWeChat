//
//  CWChatMessage.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/6.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

// 定义消息

/// 聊天类型
///
/// - single: 单聊
/// - group: 群聊
/// - chatRoom: 组聊
public enum CWChatType : Int {
    case single
    case group
    case chatroom
}


/// 会话提示类型
///
/// - none: 不提示
/// - point: 红点
/// - pointWithNumber: 数字
public enum CWConversationClueType: Int {
    case none
    case point
    case pointWithNumber
}

/// 消息搜索方向
///
/// - up: 向上搜索
/// - down: 向下搜索
public enum CWMessageSearchDirection: Int {
    case up
    case down
}

/// 消息方向
///
/// - unknown: 默认不知道
/// - send: 发送方
/// - receive: 接受方
public enum CWMessageDirection : Int {
    case unknown
    case send
    case receive
}

/// 消息发送状态
///
/// - pending: 发送未开始
/// - sending: 正在发送
/// - successed: 发送成功
/// - failed: 发送失败
public enum CWMessageSendStatus : Int {
    case pending
    case sending
    case successed
    case failed
}

/// 消息读取状态
///
/// - unRead: 未读取
/// - Readed: 已经读取
public enum CWMessageReadState : Int {
    case unread
    case readed
}

/// 消息类型
public enum CWMessageType: Int {
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


/// 聊天消息
public class CWMessage {

    /// 会话类型
    public var chatType: CWChatType = .single
    /// 消息类型
    public var messageType: CWMessageType {
        return self.messageBody.type
    }
    /// 消息唯一id
    public var messageId: String
    /// 消息发送
    public var direction: CWMessageDirection = .unknown
    /// 发送状态
    public var sendStatus: CWMessageSendStatus = .pending
    /// 目标id
    public var targetId: String
    /// 消息体
    public var messageBody: CWMessageBody
    /// 消息发送时间
    public var timestamp: TimeInterval
    /// 已读
    public var isRead: Bool = true
    /// 消息扩展
    public var ext: Dictionary<String, AnyObject>?
    
    public init(targetId: String,
                messageID: String = CWChatClientUtil.messageId,
                direction: CWMessageDirection = .send,
                timestamp: TimeInterval = CWChatClientUtil.messageDate,
                messageBody: CWMessageBody) {

        self.messageBody = messageBody
        self.direction = direction
        
        self.targetId = targetId
        self.messageId = messageID
        self.timestamp = timestamp
    }
    
}

extension CWMessage: Hashable, CustomStringConvertible {
    
    public var description: String {
        switch messageType {
        case .text:
            let textBody = self.messageBody as! CWTextMessageBody
            return "文本消息:"+textBody.text
        default:
            return "消息类型\(messageType)"
        }
    }
    
    public var hashValue: Int {
        return messageId.hashValue
    }
    
    public static func ==(lhs: CWMessage, rhs: CWMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}




