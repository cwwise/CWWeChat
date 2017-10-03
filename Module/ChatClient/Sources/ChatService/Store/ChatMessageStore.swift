//
//  ChatMessageStore.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import SQLite.Swift

class ChatMessageStore: ChatBaseStore {
    /// 判断是否存在对应的表
    private var tableExistList = [String: Bool]()
    //MARK: 数据库属性
    /// 主键
    private let f_id = Expression<Int64>("id")
    /// 消息id
    private let f_messageId = Expression<String>("msgid")
    /// from
    private let f_from = Expression<String>("from")
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
    /// 拓展字端(json)
    private let f_extra = Expression<String>("extra")
    
    func messageTable(_ conversationId: String) -> Table {
        if tableExistList[conversationId] == nil {
            createMessageTable(conversationId: conversationId)
        }
        return Table("message_" + conversationId)
    }
    
    /// 创建message数据表
    func createMessageTable(conversationId: String) {
        do {
            let table = Table("message_" + conversationId)
            let create = table.create(ifNotExists: true) { t in
                t.column(f_id, primaryKey: .autoincrement)
                t.column(f_messageId, unique: true)
                t.column(f_from)
                t.column(f_date)
                t.column(f_chatType, defaultValue: 0)
                t.column(f_direction, defaultValue: 0)
                t.column(f_messageType, defaultValue: 0)
                t.column(f_content, defaultValue: "")
                t.column(f_sendStatus, defaultValue: 0)
                t.column(f_readed, defaultValue: false)
                t.column(f_extra, defaultValue: "")}
            log.verbose(create.asSQL())
            try chatDB.run(create)
            _ = table.createIndex(f_messageId)
            
            tableExistList[conversationId] = true
        } catch {
            log.error(error)
        }
    }
    
}

// MARK: - 新增
extension ChatMessageStore {
    
    @discardableResult
    func insert(message: Message) -> Bool {
        let textBody = message.messageBody as? TextMessageBody
        print(textBody?.text)
        do {
      
            var messageContent: String?
            if message.messageType == .text {
              
                messageContent = textBody?.text
                print(messageContent ?? "")
            } else {
                let data = try messageEncoder.encode(message.messageBody)
                messageContent = String(data: data, encoding: .utf8)
            }
            
            guard let string = messageContent else {
                log.error("解析消息错误--\(message)")
                return false
            }
            
            let table = messageTable(message.conversationId)
            let insert = table.insert(f_messageId <- message.messageId,
                                      f_from <- message.from,
                                      f_date <- message.timestamp,
                                      f_chatType <- message.chatType.rawValue,
                                      f_direction <- message.direction.rawValue,
                                      f_messageType <- message.messageType.rawValue,
                                      f_sendStatus <- message.sendStatus.rawValue,
                                      f_content <- string)
            try chatDB.run(insert)
            return true
        } catch {
            log.error(error)
            return false
        }
    }
 
    
}

// MARK: 查找
extension ChatMessageStore {

    func lastMessage(by conversationId: String) -> Message? {
        let query = messageTable(conversationId).order(f_date.desc)
        do {
            let raw = try chatDB.pluck(query)
            return createMessage(by: raw, conversationId: conversationId)
        } catch {
            log.error(error)
            return nil
        }
    }
    
    func fecthMessages(conversationId: String,
                       messageId: String? = nil,
                       timestamp: TimeInterval? = nil,
                       count: Int = 20) -> [Message]{
        
        var messages = [Message]()
        
        var query = messageTable(conversationId)
        if let timestamp = timestamp {
            query = query.filter(f_date < timestamp)
        }
        query = query.order(f_date.desc).limit(count)
        do {
            let result = try chatDB.prepare(query)
            for row in result.reversed() {
                if let message = createMessage(by: row, conversationId: conversationId) {
                    messages.append(message)
                }
            }
        } catch {
            log.error(error)
        }
        
        return messages
    }
    
    func createMessage(by row: Row?, conversationId: String) -> Message? {
        guard let row = row,
            let data = row[f_content].data(using: .utf8) else {
            return nil
        }
        
        do {
            let messageType = MessageType(rawValue: row[f_messageType]) ?? .none
            var messageBody: MessageBody!
            // 文本
            if messageType == .text {
                messageBody = TextMessageBody(text: row[f_content])
            } else {
                let bodyClass = ChatClientUtil.messageBodyClass(with: messageType)
                messageBody = try messageDecoder.decode(bodyClass, from: data)
            }
            
            let message = Message(conversationId: conversationId,
                                  from: row[f_from],
                                  body: messageBody)
            let direction = MessageDirection(rawValue: row[f_direction]) ?? .send
            let sendStatus = MessageSendStatus(rawValue: row[f_sendStatus]) ?? .sending
            let chatType = ChatType(rawValue: row[f_chatType]) ?? .single

            message.direction = direction
            message.chatType = chatType
            message.sendStatus = sendStatus
            
            return message
        } catch {
            log.error(error)
            return nil
        }
    }
    
}


// MARK: - 修改
extension ChatMessageStore {
    
    func markAllMessagesAsRead(_ conversationId: String) {
        let filter = messageTable(conversationId).where(f_readed == false)
        let update = filter.update(f_readed <- true)
        do {
            try chatDB.run(update)
        } catch {
            log.error(error)
        }
        
    }
    
    func markMessageRead(_ conversationId: String, messageId: String) {
        let filter = messageTable(conversationId).filter(f_messageId == messageId)
        let update = filter.update(f_readed <- true)
        do {
            try chatDB.run(update)
        } catch {
            log.error(error)
        }
    }

    // 更新消息状态和消息内容
    func updateMessage(_ message: Message) {
       
        do {
            let data = try messageEncoder.encode(message.messageBody)
            guard let string = String(data: data, encoding: .utf8) else {
                log.error("解析消息错误--\(message)")
                return
            }
            
            let filter = messageTable(message.conversationId).filter(f_messageId == message.messageId)
            let update = filter.update(f_sendStatus <- message.sendStatus.rawValue,
                                       f_content <- string)
            
            try chatDB.run(update)

        } catch {
            log.error(error)
        }
    }
    
    func updateMessageDate(_ message: Message) {
        let filter = messageTable(message.conversationId).filter(f_messageId == message.messageId)
        let update = filter.update(f_date <- message.timestamp)
        do {
            try chatDB.run(update)
        } catch {
            log.error(error)
        }
    }
}

// MARK: - 删除
extension ChatMessageStore {
    
    /**
     删除一条消息
     
     - parameter messageID: 消息唯一的id messageID
     */
    @discardableResult
    func deleteMessage(message: Message) -> Bool {
        let query = messageTable(message.conversationId).filter(f_messageId == message.messageId)
        do {
            let delete = query.delete()
            try chatDB.run(delete)
            return true
        } catch {
            log.error(error)
            return false
        }
    }
    
    /// 删除当前用户指定人的所有聊天记录
    ///
    /// - Parameter targetId: 目标用户id
    /// - Returns: 返回删除结果
    @discardableResult
    func deleteAllMessage(conversationId: String) -> Bool {
        let query = messageTable(conversationId)
        do {
            try chatDB.run(query.delete())
            return true
        } catch {
            return false
        }
    }
    
}


