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
public class CWMessage: NSObject {

    /// 会话类型
    public var chatType: CWChatType = .single
    /// 消息类型
    public var messageType: CWMessageType {
        return self.messageBody.type
    }
    /// 消息唯一id
    public var messageId: String
    /// 消息发送方
    public var direction: CWMessageDirection = .unknown
    /// 发送状态
    public var sendStatus: CWMessageSendStatus = .pending
    /// 发送方id (自己的id) （这个地方用？可能需要修改）
    public var senderId: String?
    /// 接收方id
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
         messageID: String = String.UUIDString(),
         chatType: CWChatType = .single,
         direction: CWMessageDirection = .send,
         isRead: Bool = true,
         timestamp: TimeInterval = NSDate().timeIntervalSince1970,
         messageBody: CWMessageBody) {

        self.messageBody = messageBody
        self.timestamp = timestamp
        self.direction = direction
        self.chatType = chatType
        
        self.targetId = targetId
        self.messageId = messageID
        super.init()
        self.messageBody.message = self
    }
    
}

extension CWMessage {
    override public var description: String {
        switch messageType {
        case .text:
            let textBody = self.messageBody as! CWTextMessageBody
            return "文本消息:"+textBody.text
        default:
            return "消息类型\(messageType)"
        }
    }
    
    public override var hashValue: Int {
        return messageId.hashValue
    }
    
}


// MARK: - 便利方法
extension CWMessage {
    // 文本
    public convenience init(targetId: String,
                messageID: String = String.UUIDString(),
                chatType: CWChatType = .single,
                direction: CWMessageDirection = .send,
                isRead: Bool = true,
                timestamp: TimeInterval = NSDate().timeIntervalSince1970,
                text: String) {
        
        let messageBody = CWTextMessageBody(text: text)
        self.init(targetId: targetId,
                  messageID: messageID,
                  chatType: chatType,
                  direction: direction,
                  isRead: isRead,
                  timestamp: timestamp,
                  messageBody: messageBody)
    }
    
    
}




