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
 
 可以[查看sql](https://github.com/stephencelis/SQLite.swift/issues/399)
 
 */
class CWChatMessageStore: NSObject {
    
    let message: CWChatMessage! = nil
    
    /// 当前用户的唯一id，创建数据库名称
    var userId: String

    
    //MARK: 数据库属性
    let messageTable = Table("message")
    //消息唯一id
    let id = Expression<Int64>("id")
    // 消息id
    let messageid = Expression<String>("msgid")
    //用户唯一id
    let senderId = Expression<String>("sid")
    let targetId = Expression<String>("tid")
    // 消息时间
    let date = Expression<String>("date")
    /// type
    let chat_type = Expression<Int>("partner_type")
    /// 发送方
    let direction = Expression<Int>("direction")
    /// 消息类型 文本 图片
    let msg_type = Expression<Int>("msg_type")
    /// 内容
    let content = Expression<String?>("content")
    /// 接收状态
    let send_status = Expression<Int>("send_status")

    /// 拓展字端
    let ext1 = Expression<String>("ext1")
    
    
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
        let documentPath = NSHomeDirectory() + "/Documents"
        let path = "\(documentPath)/User/\(self.userId)/Chat/DB/"
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        log.debug(path)
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
            try messageDB.run(messageTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(messageid, unique: true)
                t.column(senderId)
                t.column(targetId)
                t.column(date)
                t.column(chat_type, defaultValue: 0)
                t.column(direction, defaultValue: 0)
                t.column(msg_type, defaultValue: 0)
                t.column(content, defaultValue: "")
                t.column(send_status, defaultValue: 0)
                t.column(ext1, defaultValue: "")
            })
            
        } catch let error as NSError {
            log.error(error)
        }
    }
    
}


// MARK: - 新增
extension CWChatMessageStore {

    func appendMessage(message: CWChatMessage) {

        var content = ""
        
        
        
        
    }
    
    
}


// MARK: - 删除
extension CWChatMessageStore {
    
    /**
     删除一条消息
     
     - parameter messageID: 消息唯一的id messageID
     */
    func deleteMessage(by messageID:String) -> Bool {
        let query = messageTable.filter(messageID == messageid)
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
    func deleteMessage(targetId: String) -> Bool {
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

