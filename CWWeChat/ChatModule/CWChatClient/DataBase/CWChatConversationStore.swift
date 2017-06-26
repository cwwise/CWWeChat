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
    
    let id = Expression<Int64>("id")
    let chatType = Expression<Int>("chat_type")
    let target_id = Expression<String>("tid")
    // 是否置顶
    let isTop = Expression<Bool>("isTop")
    let unread_count = Expression<Int>("unread_count")
    // 时间
    let date = Expression<Double>("date")
    // 草稿
    let _draft = Expression<String?>("draft")
    
    
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
                t.column(id, primaryKey: .autoincrement)
                t.column(target_id, unique: true)
                t.column(chatType, defaultValue:0)
                t.column(date)
                t.column(isTop, defaultValue: false)
                t.column(unread_count, defaultValue:0)
                t.column(_draft)
            })
            _ = conversationTable.createIndex([chatType])
        } catch {
            log.error(error)
        }
    }
    
}

extension CWChatConversationStore {
    // 添加会话
    func addConversation(conversation: CWConversation) {

        let timestamp = conversation.lastMessage?.timestamp ?? NSDate().timeIntervalSince1970
        let insert = conversationTable.insert(target_id <- conversation.targetId,
                                              isTop <- conversation.isTop,
                                              unread_count <- conversation.unreadCount,
                                              _draft <- conversation.draft,
                                              chatType <- conversation.type.rawValue,
                                              date <- timestamp
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
        let filter = conversationTable.filter(target_id == conversation.targetId)
        let timestamp = conversation.lastMessage?.timestamp ?? NSDate().timeIntervalSince1970
        
        let update = filter.update(date <- timestamp)
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
            let result = try messageDB.prepare(conversationTable.order(date))
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
        let sql = conversationTable.filter(type.rawValue==chatType && targetId == target_id)
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
        let targetId = row[target_id]
        let type = CWChatType(rawValue: row[chatType]) ?? .single
        let conversation = CWConversation(targetId: targetId, type: type)
        conversation.draft = row[_draft]
        conversation.unreadCount = row[unread_count]
        conversation.isTop = row[isTop]
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
            let query = conversationTable.filter(targetId==target_id)
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

