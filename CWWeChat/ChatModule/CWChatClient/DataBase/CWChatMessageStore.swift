//
//  CWChatMessageStore.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/28.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SQLite

/**
 消息管理类
 
 使用SQLite.swift
 */
class CWChatMessageStore: CWChatBaseStore {
        
    // 判断是否存在对应的表
    private var tableExistList = [String: Bool]()
    
    //MARK: 数据库属性
    //消息唯一id
    private let id = Expression<Int64>("id")
    // 消息id
    private let messageId = Expression<String>("msgid")
    //用户唯一id
    private let senderId = Expression<String>("sid")
    private let target_Id = Expression<String>("tid")
    // 消息时间
    private let date = Expression<Double>("date")
    /// type
    private let chatType = Expression<Int>("chat_type")
    /// 发送方
    private let direction = Expression<Int>("direction")
    /// 消息类型 文本 图片
    private let messageType = Expression<Int>("msg_type")
    /// 内容
    private let content = Expression<String>("content")
    /// 接收状态
    private let sendStatus = Expression<Int>("send_status")
    /// 是否已读
    private let readed = Expression<Bool>("readed")
    
    /// 拓展字端
    private let ext1 = Expression<String>("ext1")

    func messageTable(_ targetId: String) -> Table {
        if tableExistList[targetId] == nil {
            createMessageTable(targetId: targetId)
        }
        return Table("message_"+targetId)
    }
    
    /// 创建message数据表
    func createMessageTable(targetId: String) {
        do {
            let table = Table("message_"+targetId)
            let create = table.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(messageId, unique: true)
                t.column(senderId)
                t.column(target_Id)
                t.column(date)
                t.column(chatType, defaultValue: 0)
                t.column(direction, defaultValue: 0)
                t.column(messageType, defaultValue: 0)
                t.column(content, defaultValue: "")
                t.column(sendStatus, defaultValue: 0)
                t.column(readed, defaultValue: false)
                t.column(ext1, defaultValue: "")}
            log.verbose(create.asSQL())
            try messageDB.run(create)
            _ = table.createIndex(messageId)
            
            tableExistList[targetId] = true
        } catch {
            log.error(error)
        }
    }
    
}


// MARK: - 新增
extension CWChatMessageStore {

    func appendMessage(_ message: CWMessage) {

        guard let sendId = message.senderId else {
            log.error("插入消息失败,缺少消息sendId.")
            return
        }
        let body = message.messageBody.messageEncode
        let insert = messageTable(message.targetId).insert(messageId <- message.messageId,
                                         target_Id <- message.targetId,
                                         senderId <- sendId,
                                         date <- message.timestamp,
                                         chatType <- message.chatType.rawValue,
                                         direction <- message.direction.rawValue,
                                         messageType <- message.messageType.rawValue,
                                         content <- body,
                                         sendStatus <- message.sendStatus.rawValue)
        log.verbose(insert.asSQL())
        do {
            try messageDB.run(insert)
        } catch {
            log.error(error)
        }
    }
}

// MARK: 查找
extension CWChatMessageStore {

    func lastMessage(by targetId: String) -> CWMessage? {
        let query = messageTable(targetId).filter(target_Id == targetId).order(date.desc)
        do {
            let raw = try messageDB.pluck(query)
            return createMessageByRow(raw)
        } catch {
            log.error(error)
            return nil
        }
    }
    
    func fecthMessages(targetId: String,
                       messageId: String? = nil,
                       timestamp: Double? = nil,
                       count: Int = 20) -> [CWMessage]{
        
        var messages = [CWMessage]()
        
        var query = messageTable(targetId).filter(targetId == target_Id)
        if timestamp != nil {
            query = query.filter(date < timestamp!)
        }
        query = query.order(date.desc).limit(count)
        
        do {
            let result = try messageDB.prepare(query)
            for row in result.reversed() {
                let message = createMessageByRow(row)!
                messages.append(message)
            }
            
        } catch {
            log.error(error)
        }
        
        return messages
    }
    
    func createMessageByRow(_ row: Row?) -> CWMessage? {
        guard let row = row else {
            return nil
        }
        
        let type = CWMessageType(rawValue: row[messageType]) ?? CWMessageType.none
        var body: CWMessageBody!
        switch type {
        case .text:
           body = CWTextMessageBody(text: row[content])
        case .image:
            body = CWImageMessageBody()
            body.messageDecode(string: row[content])
            
        case .emoticon:
            body = CWEmoticonMessageBody()
            body.messageDecode(string: row[content])
            
        case .location:
            body = CWLocationMessageBody()
            body.messageDecode(string: row[content])

        default: break
            
        }
        
        
        guard let messageBody = body else {
            return nil
        }
        
        let _direction = CWMessageDirection(rawValue: row[direction]) ?? .unknown
        let message = CWMessage(targetId: row[target_Id],
                                    messageID: row[messageId],
                                    direction: _direction,
                                    timestamp: row[date],
                                    messageBody: messageBody)
        message.sendStatus = CWMessageSendStatus(rawValue: row[sendStatus]) ?? .pending
        message.senderId = row[senderId]
        return message
    }
}

// MARK: - 修改
extension CWChatMessageStore {
    
    func markAllMessagesAsRead(_ targetId: String) {
        let filter = messageTable(targetId).filter(target_Id == targetId).where(readed == false)
        let update = filter.update(readed <- true)
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
        
    }
    
    func markMessageRead(_ targetId: String, message_Id: String) {
        let filter = messageTable(targetId).filter(messageId == message_Id)
        let update = filter.update(readed <- true)
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
    }
    
    func updateMessage(_ message: CWMessage) {
        let filter = messageTable(message.targetId).filter(messageId == message.messageId)
        let body = message.messageBody.messageEncode
        let update = filter.update(sendStatus <- message.sendStatus.rawValue,
                                   content <- body)

        log.verbose(update.asSQL())
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
    }
    
    func updateMessageDate(_ message: CWMessage) {
        let filter = messageTable(message.targetId).filter(messageId == message.messageId)
        let update = filter.update(date <- message.timestamp)
        log.verbose(update.asSQL())
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
    }
    
}

// MARK: - 删除
extension CWChatMessageStore {
    
    /**
     删除一条消息
     
     - parameter messageID: 消息唯一的id messageID
     */
    func deleteMessage(targetId: String, messageID:String) -> Bool {
        let query = messageTable(targetId).filter(messageID == messageId)
        do {
            let rowid = try messageDB.run(query.delete())
            log.debug("删除消息成功: \(rowid), \(messageID)")
            return true
        } catch {
            log.error("删除消息失败: \(error)")
            return false
        }
    }
    
    /// 删除当前用户指定人的所有聊天记录
    ///
    /// - Parameter targetId: 目标用户id
    /// - Returns: 返回删除结果
    @discardableResult func deleteMessages(targetId: String) -> Bool {
        let query = messageTable(targetId)
        do {
            let _ = try messageDB.run(query.delete())
            log.debug("删除用户\(targetId)消息成功")
            return true
        } catch {
            log.error("删除用户\(targetId)消息失败: \(error)")
            return false
        }
    }

}

