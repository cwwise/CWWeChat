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
class CWChatMessageStore: NSObject {
    
    /// 当前用户的唯一id，创建数据库名称
    private(set) var userId: String
    
    //MARK: 数据库属性
    fileprivate let messageTable = Table("message")
    //消息唯一id
    fileprivate let id = Expression<Int64>("id")
    // 消息id
    fileprivate let messageId = Expression<String>("msgid")
    //用户唯一id
    fileprivate let senderId = Expression<String>("sid")
    fileprivate let target_Id = Expression<String>("tid")
    // 消息时间
    fileprivate let date = Expression<Double>("date")
    /// type
    fileprivate let chatType = Expression<Int>("chat_type")
    /// 发送方
    fileprivate let direction = Expression<Int>("direction")
    /// 消息类型 文本 图片
    fileprivate let messageType = Expression<Int>("msg_type")
    /// 内容
    fileprivate let content = Expression<String>("content")
    /// 接收状态
    fileprivate let sendStatus = Expression<Int>("send_status")
    /// 是否已读
    fileprivate let readed = Expression<Bool>("readed")
    
    /// 拓展字端
    fileprivate let ext1 = Expression<String>("ext1")
    
    lazy var messageDB:Connection = {
        //数据
        do {
            let messageDB = try Connection(self.path)
            messageDB.busyTimeout = 3
            messageDB.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            return messageDB
        } catch {
            print(error)
            return try! Connection()
        }
    }()
    
    /// 数据库路径
    lazy var path: String = {
        let userPath = CWChatClient.share.userFilePath
        let path = "\(userPath)/chat/"
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        log.verbose(path)
        return path + "chatmessage.sqlite3"
    }()
    
    //MARK: 初始化
    init(userId: String) {
        self.userId = userId
        super.init()
        createMessageTable()
    }
    
    /// 创建message数据表
    func createMessageTable() {
        do {
            let create = messageTable.create(ifNotExists: true) { t in
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
            _ = messageTable.createIndex([messageId])
        } catch {
            log.error(error)
        }
    }
    
}


// MARK: - 新增
extension CWChatMessageStore {

    func appendMessage(_ message: CWChatMessage) {

        guard let sendId = message.senderId else {
            log.error("插入消息失败,缺少消息sendId.")
            return
        }
        let body = message.messageBody.messageEncode
        let insert = messageTable.insert(messageId <- message.messageId,
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

    func lastMessage(by targetId: String) -> CWChatMessage? {
        let query = messageTable.filter(target_Id == targetId).order(date.desc)
        do {
            let raw = try messageDB.pluck(query)
            return createMessageByRow(raw)
        } catch {
            log.error(error)
            return nil
        }
    }
    
    func fecthMessages(targetId: String,
                       timestamp: Double? = nil,
                       count: Int = 20) -> [CWChatMessage]{
        
        var messages = [CWChatMessage]()
        
        var query = messageTable.filter(targetId == target_Id)
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
    
    func createMessageByRow(_ row: Row?) -> CWChatMessage? {
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
        default: break
            
        }
        
        
        let _direction = CWMessageDirection(rawValue: row[direction]) ?? .unknown
        let message = CWChatMessage(targetId: row[target_Id],
                                    messageID: row[messageId],
                                    direction: _direction,
                                    timestamp: row[date],
                                    messageBody: body)
        message.sendStatus = CWMessageSendStatus(rawValue: row[sendStatus]) ?? .pending
        message.senderId = row[senderId]
        return message
    }
}

// MARK: - 修改
extension CWChatMessageStore {
    
    func markAllMessagesAsRead(_ targetId: String) {
        let filter = messageTable.filter(target_Id == targetId).where(readed == false)
        let update = filter.update(readed <- true)
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
        
    }
    
    func markMessageRead(_ _messageId: String) {
        let filter = messageTable.filter(messageId == _messageId)
        let update = filter.update(readed <- true)
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
    }
    
    func updateMessage(_ message: CWChatMessage) {
        let filter = messageTable.filter(messageId == message.messageId)
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
    
    func updateMessageDate(_ message: CWChatMessage) {
        let filter = messageTable.filter(messageId == message.messageId)
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
    func deleteMessage(by messageID:String) -> Bool {
        let query = messageTable.filter(messageID == messageId)
        do {
            let rowid = try messageDB.run(query.delete())
            log.debug("删除消息成功: \(rowid), \(messageID)")
            return true
        } catch {
            log.error("删除消息失败: \(error)")
            return false
        }
    }
    
    /// 删除当前用户指定人的聊天记录
    ///
    /// - Parameter targetId: 目标用户id
    /// - Returns: 返回删除结果
    @discardableResult func deleteMessages(by targetId: String) -> Bool {
        let query = messageTable.filter(senderId == self.userId && targetId == targetId)
        do {
            let _ = try messageDB.run(query.delete())
            log.debug("删除用户\(targetId)消息成功")
            return true
        } catch {
            log.error("删除用户\(targetId)消息失败: \(error)")
            return false
        }
    }
    
    /**
     删除所有聊天记录
     */
    func deleteAllMessage() {
        do {
            _ = try messageDB.run(messageTable.delete())
        } catch {
            log.error("删除全部消息失败: \(error)")
        }
    }
}

