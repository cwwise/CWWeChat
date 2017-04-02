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
    case location           //位置
    case expression         //表情
    
    //获取cell的reuseIdentifier
    func identifier() -> String {
        switch self {
        case .text:
            return "ChatMessageTextCell"
        case .image:
            return "ChatMessageImageCell"
        case .voice:
            return "ChatMessageVoiceCell"
        case .video:
            return "ChatMessageVideoCell"
        case .expression:
            return "ChatMessageExpressionCell"
        default:
            return "ChatMessageCell"
        }
    }
}


/// 聊天消息
class CWChatMessage: NSObject {

    /// 会话类型
    var chatType: CWChatType = .single
    /// 消息类型
    var messageType: CWMessageType {
        return self.messageBody.type
    }
    /// 消息唯一id
    var messageId: String
    /// 消息发送方
    var direction: CWMessageDirection = .unknown
    /// 发送状态
    var sendStatus: CWMessageSendStatus = .pending
    /// 发送方id (自己的id)
    var senderId: String?
    /// 接收方id
    var targetId: String
    /// 消息体
    var messageBody: CWMessageBody
    /// 消息发送时间
    var timestamp: TimeInterval
    /// 消息扩展
    var ext: Dictionary<String, Any>?
    
    
    init(targetId: String,
         messageID: String = String.UUIDString(),
         direction: CWMessageDirection = .send,
         timestamp: TimeInterval = NSDate().timeIntervalSince1970,
         messageBody: CWMessageBody) {

        self.messageBody = messageBody
        self.timestamp = timestamp
        self.direction = direction
        
        self.targetId = targetId
        self.messageId = messageID
        super.init()
        self.messageBody.message = self
    }
    
}

extension CWChatMessage {
    override var description: String {
        switch messageType {
        case .text:
            let textBody = self.messageBody as! CWTextMessageBody
            return "文本消息:"+textBody.text
        default:
            return "消息类型\(messageType)"
        }
    }
}


