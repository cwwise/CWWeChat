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
    private var messageTableList = [String: Table]()
    
    //MARK: 数据库属性
    //消息唯一id
    private let f_id = Expression<Int64>("id")
    // 消息id
    private let f_messageId = Expression<String>("msgid")
    //用户唯一id
    private let f_targetId = Expression<String>("tid")
    // 消息时间
    private let f_date = Expression<Double>("date")
    /// type
    private let f_chatType = Expression<Int>("chattype")
    /// 发送方
    private let f_direction = Expression<Int>("direction")
    /// 消息类型 文本 图片
    private let f_messageType = Expression<Int>("msgtype")
    /// 内容
    private let f_content = Expression<String>("content")
    /// 接收状态
    private let f_sendStatus = Expression<Int>("sendstatus")
    /// 是否已读
    private let f_readed = Expression<Bool>("readed")
    /// 拓展字端
    private let f_ext1 = Expression<String>("ext1")

    /// http://www.jianshu.com/p/32563e843cc0
    /// 全文检索
    let textTable = VirtualTable("content")
    let f_body = Expression<String>("body")
    let f_bodyId = Expression<String>("msgid")

    
    func messageTable(_ targetId: String) -> Table {
        if messageTableList[targetId] == nil {
            createMessageTable(targetId: targetId)
        }
        assert(messageTableList[targetId] != nil)
        return messageTableList[targetId]!
    }
    
    override init(userId: String) {
        super.init(userId: userId)
        do {
            try messageDB.run(textTable.create(.FTS4([f_bodyId, f_body], tokenize: .Porter), ifNotExists: true))
        } catch  {
            print(error)
        }
    }
    
    /// 创建message数据表
    func createMessageTable(targetId: String) {
        do {
            let table = Table("message_"+targetId)
            let create = table.create(ifNotExists: true) { t in
                t.column(f_id, primaryKey: .autoincrement)
                t.column(f_messageId, unique: true)
                t.column(f_targetId)
                t.column(f_date)
                t.column(f_chatType, defaultValue: 0)
                t.column(f_direction, defaultValue: 0)
                t.column(f_messageType, defaultValue: 0)
                t.column(f_content, defaultValue: "")
                t.column(f_sendStatus, defaultValue: 0)
                t.column(f_readed, defaultValue: false)
                t.column(f_ext1, defaultValue: "")}
            log.verbose(create.asSQL())
            try messageDB.run(create)
            _ = table.createIndex(f_messageId)
            
            messageTableList[targetId] = table
        } catch {
            log.error(error)
        }
    }
    
    override func setupMessageDB() {
        super.setupMessageDB()
        messageTableList.removeAll(keepingCapacity: true)
    }
    
}


// MARK: - 新增
extension CWChatMessageStore {

    func appendMessage(_ message: CWMessage) {

        let body = message.messageBody.messageEncode
        let insert = messageTable(message.targetId).insert(f_messageId <- message.messageId,
                                         f_targetId <- message.targetId,
                                         f_date <- message.timestamp,
                                         f_chatType <- message.chatType.rawValue,
                                         f_direction <- message.direction.rawValue,
                                         f_messageType <- message.messageType.rawValue,
                                         f_content <- body,
                                         f_sendStatus <- message.sendStatus.rawValue)
        
        log.verbose(insert.asSQL())
        do {
            if message.messageType == .text {
                let textBody = message.messageBody as! CWTextMessageBody
                try messageDB.run(textTable.insert(
                    f_body <- textBody.text,
                    f_bodyId <- message.messageId
                ))
            }
            try messageDB.run(insert)
        } catch {
            log.error(error)
        }
    }
}

// MARK: 查找
extension CWChatMessageStore {

    func fullTextSearch(_ text: String) {
        let query = textTable.filter(f_body.match("\(text)*"))
        do {
            print(query.asSQL())
            let result = try messageDB.prepare(query)
            for row in result.reversed() {
                print(row)
            }
        } catch {
            print(error)
        }
        
    }
    
    func lastMessage(by targetId: String) -> CWMessage? {
        let query = messageTable(targetId).filter(f_targetId == targetId).order(f_date.desc)
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
        
        var query = messageTable(targetId).filter(targetId == f_targetId)
        if timestamp != nil {
            query = query.filter(f_date < timestamp!)
        }
        query = query.order(f_date.desc).limit(count)
        
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
        
        let type = CWMessageType(rawValue: row[f_messageType]) ?? CWMessageType.none
        var body: CWMessageBody!
        switch type {
        case .text:
           body = CWTextMessageBody(text: row[f_content])
        case .image:
            body = CWImageMessageBody()
            body.messageDecode(string: row[f_content])
            
        case .emoticon:
            body = CWEmoticonMessageBody()
            body.messageDecode(string: row[f_content])
            
        case .location:
            body = CWLocationMessageBody()
            body.messageDecode(string: row[f_content])

        default: break
            
        }
        
        
        guard let messageBody = body else {
            return nil
        }
        
        let direction = CWMessageDirection(rawValue: row[f_direction]) ?? .unknown
        let message = CWMessage(targetId: row[f_targetId],
                                    messageID: row[f_messageId],
                                    direction: direction,
                                    timestamp: row[f_date],
                                    messageBody: messageBody)
        message.sendStatus = CWMessageSendStatus(rawValue: row[f_sendStatus]) ?? .pending
        return message
    }
}

// MARK: - 修改
extension CWChatMessageStore {
    
    func markAllMessagesAsRead(_ targetId: String) {
        let filter = messageTable(targetId).filter(f_targetId == targetId).where(f_readed == false)
        let update = filter.update(f_readed <- true)
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
        
    }
    
    func markMessageRead(_ targetId: String, messageId: String) {
        let filter = messageTable(targetId).filter(f_messageId == messageId)
        let update = filter.update(f_readed <- true)
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
    }
    
    func updateMessage(_ message: CWMessage) {
        let filter = messageTable(message.targetId).filter(f_messageId == message.messageId)
        let body = message.messageBody.messageEncode
        let update = filter.update(f_sendStatus <- message.sendStatus.rawValue,
                                   f_content <- body)

        log.verbose(update.asSQL())
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
    }
    
    func updateMessageDate(_ message: CWMessage) {
        let filter = messageTable(message.targetId).filter(f_messageId == message.messageId)
        let update = filter.update(f_date <- message.timestamp)
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
    func deleteMessage(targetId: String, messageId:String) -> Bool {
        let query = messageTable(targetId).filter(messageId == f_messageId)
        do {
            let rowid = try messageDB.run(query.delete())
            log.debug("删除消息成功: \(rowid), \(messageId)")
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

