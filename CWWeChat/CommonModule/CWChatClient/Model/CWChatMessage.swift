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
public enum CWConversationType : Int {
    case single
    case group
    case chatroom
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
/// - delivering: 正在发送
/// - successed: 发送成功
/// - failed: 发送失败
public enum CWMessageSendStatus : Int {
    case pending
    case delivering
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


/// 聊天消息
class CWChatMessage: NSObject {

    /// 会话类型
    var conversationType: CWConversationType = .single
    
    /// 消息唯一id
    var messageId: String!
    
    var direction: CWMessageDirection!
    
    var senderId: String!
    
    var targetId: String!
    
    var sendStatus: CWMessageSendStatus!
    
}
