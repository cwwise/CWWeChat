//
//  CWConversationStore.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SQLite

/**
 会话管理类
 
 使用SQLite.swift
 */
class CWChatConversationStore: CWChatBaseStore {

    /// 当前用户的唯一id，创建数据库名称
    let conversationTable = Table("conversation")
    /// id
    let f_id = Expression<Int64>("id")
    /// 聊天类型
    let f_chatType = Expression<Int>("chat_type")
    let f_targetId = Expression<String>("tid")
    // 是否置顶
    let f_isTop = Expression<Bool>("isTop")
    let f_unreadCount = Expression<Int>("unread_count")
    // 时间
    let f_date = Expression<Double>("date")
    // 草稿
    let f_draft = Expression<String?>("draft")
    
    //MARK: 初始化
    override init(userId: String) {
        super.init(userId: userId)
        createMessageTable()
    }
    
    /**
     创建Table
     */
    func createMessageTable() {
        do {
            try messageDB.run(conversationTable.create(ifNotExists: true) { t in
                t.column(f_id, primaryKey: .autoincrement)
                t.column(f_targetId, unique: true)
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

extension CWChatConversationStore {
    // 添加会话
    func addConversation(conversation: CWConversation) {

        let timestamp = conversation.lastMessage?.timestamp ?? NSDate().timeIntervalSince1970
        let insert = conversationTable.insert(f_targetId <- conversation.targetId,
                                              f_isTop <- conversation.isTop,
                                              f_unreadCount <- conversation.unreadCount,
                                              f_draft <- conversation.draft,
                                              f_chatType <- conversation.type.rawValue,
                                              f_date <- timestamp
                                              )
        log.verbose(insert.asSQL())
        do {
            try messageDB.run(insert)
        } catch {
            log.error(error)
        }
    }
    
    // 更新会话时间
    func updateConversationTime(_ conversation: CWConversation) {
        let filter = conversationTable.filter(f_targetId == conversation.targetId)
        let timestamp = conversation.lastMessage?.timestamp ?? NSDate().timeIntervalSince1970
        
        let update = filter.update(f_date <- timestamp)
        do {
            try messageDB.run(update)
        } catch {
            log.error(error)
        }
        
    }
    
}

// MARK: 查找
extension CWChatConversationStore {
    
    func fecthAllConversations() -> [CWConversation] {
        var list = [CWConversation]()
        do {
            let result = try messageDB.prepare(conversationTable.order(f_date))
            for conversation in result {
                let model = self.createConversationByRow(conversation)
                list.append(model)
            }
        } catch {
            log.error(error)
        }
        return list
    }
    
    func fecthConversation(_ type: CWChatType, 
                           targetId: String, 
                           isExist: UnsafeMutablePointer<Bool>? = nil) -> CWConversation {
        
        var conversation: CWConversation
        var create = true
        let sql = conversationTable.filter(type.rawValue==f_chatType && targetId == f_targetId)
        do {
            let raw = try messageDB.pluck(sql)
            if raw != nil {
                conversation = createConversationByRow(raw!)
                create = false
            } else {
                conversation = CWConversation(targetId: targetId, type: type)
            }
        } catch  {
            log.error(error)
            conversation = CWConversation(targetId: targetId, type: type)
        }
        
        if (isExist != nil) {
            isExist?.pointee = !create
        }
        
        return conversation
    }
    
    
    func createConversationByRow(_ row: Row) -> CWConversation {
        let targetId = row[f_targetId]
        let type = CWChatType(rawValue: row[f_chatType]) ?? .single
        let conversation = CWConversation(targetId: targetId, type: type)
        conversation.draft = row[f_draft]
        conversation.unreadCount = row[f_unreadCount]
        conversation.isTop = row[f_isTop]
        return conversation
    }
    
}

// MARK: - 删除会话
extension CWChatConversationStore {
    
    /// 删除会话
    ///
    /// - Parameter targetId: 会话id
    @discardableResult func deleteConversation(_ targetId: String) -> Bool {
        do {
            let query = conversationTable.filter(targetId==f_targetId)
            try messageDB.run(query.delete())
            return true
        } catch {
            log.error(error)
            return false
        }
    }
    
    @discardableResult func deleteConversations() -> Bool {
        do {
            try messageDB.run(conversationTable.delete())
            return true
        } catch {
            log.error(error)
            return false
        }
    }
    
}

