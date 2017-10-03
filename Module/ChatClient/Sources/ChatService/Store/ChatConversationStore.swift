//
//  ChatConversationStore.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import SQLite.Swift

class ChatConversationStore: ChatBaseStore {

    /// Table
    let conversationTable = Table("conversation")
    /// id
    let f_id = Expression<Int64>("id")
    /// 聊天类型
    let f_chatType = Expression<Int>("chat_type")
    /// 会话id
    let f_conversationId = Expression<String>("cid")
    /// 是否置顶
    let f_isTop = Expression<Bool>("isTop")
    /// 未读
    let f_unreadCount = Expression<Int>("unread_count")
    // 时间(排序使用)
    let f_date = Expression<Double>("date")
    // 草稿
    let f_draft = Expression<String?>("draft")
    
    override init(userId: String) {
        super.init(userId: userId)
        createTable()
    }
    
    /// 创建表
    func createTable() {
        do {
            try chatDB.run(conversationTable.create(ifNotExists: true) { t in
                t.column(f_id, primaryKey: .autoincrement)
                t.column(f_conversationId, unique: true)
                t.column(f_chatType, defaultValue:0)
                t.column(f_date)
                t.column(f_isTop, defaultValue: false)
                t.column(f_unreadCount, defaultValue:0)
                t.column(f_draft)
            })
            _ = conversationTable.createIndex(f_chatType)
        } catch {
            log.error(error)
        }
    }
}

extension ChatConversationStore {
    // 添加会话
    @discardableResult
    func insert(conversation: Conversation) -> Bool {
        
        let timestamp = conversation.lastMessage?.timestamp ?? ChatClientUtil.currentTime
        let insert = conversationTable.insert(f_conversationId <- conversation.conversationId,
                                              f_isTop <- conversation.isTop,
                                              f_unreadCount <- conversation.unreadCount,
                                              f_draft <- conversation.draft,
                                              f_chatType <- conversation.type.rawValue,
                                              f_date <- timestamp)
        
        do {
            try chatDB.run(insert)
            return true
        } catch {
            log.error(error)
            return false
        }
    }
    
    // 更新会话时间
    func updateConversationTime(_ conversation: Conversation) {
        let filter = conversationTable.filter(f_conversationId == conversation.conversationId)
        let timestamp = conversation.lastMessage?.timestamp ?? ChatClientUtil.currentTime
        do {
            let update = filter.update(f_date <- timestamp)
            try chatDB.run(update)
        } catch {
            log.error(error)
        }
    }
    
}

// MARK: 查找
extension ChatConversationStore {
    
    func fecthAllConversations() -> [Conversation] {
        var list = [Conversation]()
        do {
            let query = conversationTable.order(f_date)
            let result = try chatDB.prepare(query)
            for row in result {
                let model = self.createConversation(by: row)
                list.append(model)
            }
        } catch {
            log.error(error)
        }
        return list
    }
    
    func fecthConversation(type: ChatType, 
                           conversationId: String, 
                           isExist: UnsafeMutablePointer<Bool>? = nil) -> Conversation {
        
        var conversation: Conversation
        var create = true
        let query = conversationTable.filter(type.rawValue == f_chatType && conversationId == f_conversationId)
        do {
            if let raw = try chatDB.pluck(query) {
                conversation = createConversation(by: raw)
                create = false
            } else {
                conversation = Conversation(conversationId: conversationId, type: type)
            }
        } catch  {
            log.error(error)
            conversation = Conversation(conversationId: conversationId, type: type)
        }
        
        if let isExist = isExist {
            isExist.pointee = !create
        }
        return conversation
    }
    
    func createConversation(by row: Row) -> Conversation {
        let conversationId = row[f_conversationId]
        let type = ChatType(rawValue: row[f_chatType]) ?? .single
        let conversation = Conversation(conversationId: conversationId, type: type)
        conversation.draft = row[f_draft]
        conversation.unreadCount = row[f_unreadCount]
        conversation.isTop = row[f_isTop]
        return conversation
    }
    
}

// MARK: - 删除会话
extension ChatConversationStore {
    
    /// 删除会话
    ///
    /// - Parameter targetId: 会话id
    @discardableResult 
    func deleteConversation(conversationId: String) -> Bool {
        do {
            let query = conversationTable.filter(f_conversationId == conversationId)
            try chatDB.run(query.delete())
            return true
        } catch {
            log.error(error)
            return false
        }
    }
    
    @discardableResult
    func deleteAllConversations() -> Bool {
        do {
            try chatDB.run(conversationTable.delete())
            return true
        } catch {
            log.error(error)
            return false
        }
    }
    
}

