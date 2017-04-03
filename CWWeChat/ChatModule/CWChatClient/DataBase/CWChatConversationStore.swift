//
//  CWChatConversationStore.swift
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
class CWChatConversationStore: NSObject {

    /// 当前用户的唯一id，创建数据库名称
    var userId: String
    
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
    
    lazy var conversationDB:Connection = {
        do {
            let connection = try Connection(self.path)
            connection.busyTimeout = 3
            connection.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            return connection
        } catch  {
            log.error(error)
            return try! Connection()
        }
    }()
    
    /// 数据库路径
    lazy var path: String = {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = "\(documentPath)/cwchat/\(self.userId)/chat/"
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        log.verbose(path)
        return path + "chatsession.sqlite3"
    }()
    
    //MARK: 初始化
    init(userId: String) {
        self.userId = userId
        super.init()
        createMessageTable()
    }
    
    /**
     创建TableView
     */
    func createMessageTable() {
        do {
            try conversationDB.run(conversationTable.create(ifNotExists: true) { t in
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
    func addConversation(conversation: CWChatConversation) {

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
            try conversationDB.run(insert)
        } catch {
            log.error(error)
        }
    }
    
    // 更新会话时间
    func updateConversationTime(_ conversation: CWChatConversation) {
        let filter = conversationTable.filter(target_id == conversation.targetId)
        let timestamp = conversation.lastMessage?.timestamp ?? NSDate().timeIntervalSince1970
        
        let update = filter.update(date <- timestamp)
        do {
            try conversationDB.run(update)
        } catch {
            log.error(error)
        }
        
    }
    
}

// MARK: 查找
extension CWChatConversationStore {
    
    func fecthAllConversations() -> [CWChatConversation] {
        var list = [CWChatConversation]()
        do {
            let result = try conversationDB.prepare(conversationTable.order(date))
            for conversation in result {
                let model = self.createConversationByRow(conversation)
                list.append(model)
            }
        } catch {
            log.error(error)
        }
        return list
    }
    
    func fecthConversation(_ type: CWChatType, targetId: String, isExist: UnsafeMutablePointer<Bool>? = nil) -> CWChatConversation {
        
        var conversation: CWChatConversation
        var create = true
        let sql = conversationTable.filter(type.rawValue==chatType && targetId == target_id)
        do {
            let raw = try conversationDB.pluck(sql)
            if raw != nil {
                conversation = createConversationByRow(raw!)
                create = false
            } else {
                conversation = CWChatConversation(targetId: targetId, type: type)
            }
        } catch  {
            log.error(error)
            conversation = CWChatConversation(targetId: targetId, type: type)
        }
        
        if (isExist != nil) {
            isExist?.pointee = !create
        }
        
        return conversation
    }
    
    
    func createConversationByRow(_ row: Row) -> CWChatConversation {
        let targetId = row[target_id]
        let type = CWChatType(rawValue: row[chatType]) ?? .single
        let conversation = CWChatConversation(targetId: targetId, type: type)
        conversation.draft = row[_draft]
        conversation.unreadCount = row[unread_count]
        conversation.isTop = row[isTop]
        return conversation
    }
    
}

// MARK: - 删除会话
extension CWChatConversationStore {
    
    func deleteConversation(targetId: String, deleteMessage delete:Bool = false) {
        do {
            let query = conversationTable.filter(targetId==target_id)
            try conversationDB.run(query.delete())
            // 如果删除
            if delete {
                
            }
            
        } catch {
            log.error(error)
        }
    }
    
}

