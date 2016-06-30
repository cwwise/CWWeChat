
//
//  CWChatDBRecordStore.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/27.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SQLite

class CWChatDBRecordStore: NSObject {
    
    ///用户id
    var userId: String
    
    let recordTable = Table("record")
    //消息唯一id
    let uId = Expression<String>("uid")
    
    let friendId = Expression<String>("fid")
    let record_type = Expression<Int>("record_type")
    //时间
    let date = Expression<String>("date")
    let unread_count = Expression<Int>("unread_count")
    let ext1 = Expression<String>("ext1")
   
    ///消息数据库的单利
    lazy var messageDBStore:CWChatDBMessageStore = {
        return CWChatDBDataManager.sharedInstance.dbMessageStore
    }()
    
    lazy var recordDB:Connection = {
        do {
            let recordDB = try Connection(self.path)
            recordDB.busyTimeout = 3
            recordDB.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            return recordDB
        } catch {
            print(error)
            return try! Connection()
        }
    }()
    
    lazy var path: String = {
        let documentPath = NSHomeDirectory().stringByAppendingString("/Documents")
        let path = "\(documentPath)/User/\(self.userId)/Chat/DB/"
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        return path.stringByAppendingString("chatrecord.sqlite3")
    }()
    
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
            try recordDB.run(recordTable.create(ifNotExists: true) { t in
                t.column(uId)
                t.column(friendId)
                t.column(record_type, defaultValue:0)
                t.column(date)
                t.column(unread_count, defaultValue:0)
                t.column(ext1,defaultValue:"")
                t.primaryKey(uId,friendId)
                })
        } catch {
            print(error)
        }
    }
    
    
    // MARK: 添加消息
    /**
     添加消息
     
     - parameter message: 消息体
     
     - returns: 添加消息的结果
     */
    func addRecordByMessage(message: CWMessageProtocol, needUnread unread:Bool = false) -> Bool {
        let dataString = "\(message.messageSendDate.timeIntervalSince1970)"
        var unreadCount = unreadMessageByUid(message.messageSendId!, fid: message.messageReceiveId!)
        if unread {
            unreadCount += 1
        }
        do {
            let query = recordTable.filter(uId==message.messageSendId! && friendId == message.messageReceiveId!)
            let count = recordDB.scalar(query.count)
            if count == 0 {
                try recordDB.run(recordTable.insert(uId <- message.messageSendId!,
                    friendId <- message.messageReceiveId!,
                    record_type <- message.messageType.rawValue,
                    date <- dataString,
                    unread_count <- unreadCount,
                    ext1 <- ""))
                return true
            } else {
                return updateRecord(message, unread_count: unreadCount)
            }
        } catch {
            print(error)
            return false
        }
    }
    
    // MARK: 更新消息
    func updateRecord(message:CWMessageProtocol, unread_count count:Int = 0) -> Bool {
        
        let query = recordTable.filter(uId==message.messageSendId! && friendId == message.messageReceiveId!)
        do {
            let dataString = "\(message.messageSendDate.timeIntervalSince1970)"
            try recordDB.run(query.update(date <- dataString,
                unread_count <- count))
        } catch let error as NSError {
            CWLogError(error)
        }
        return false
    }
    
    /**
     获取未读消息数量
     
     - parameter uid: sendId
     - parameter fid: 对方的id
     
     - returns: 返回unreadCount
     */
    func unreadMessageByUid(uid:String, fid:String) -> Int {
        let query = recordTable.filter(userId==uid && friendId==fid)
        var unreadCount:Int = 0
        do {
            let result = try recordDB.prepare(query)
            for row in result {
                unreadCount = row[unread_count]
            }
        } catch let error as NSError {
            CWLogError(error)
        }
        return unreadCount
    }
    
    
    func updateUnReadCountToZeroWithUserId(uid:String, fid:String) {
        let query = recordTable.filter(userId==uid && friendId==fid)
        do {
            try recordDB.run(query.update(unread_count <- 0))
        } catch {
            print(error)
        }
    }
    
    // MARK: 删除消息
    /**
     删除单条会话
     
     - parameter uid: 用户唯一表示
     - parameter fid: 朋友的唯一表示
     
     - returns: 删除结果
     */
    func deleteMessageRecordByUid(uid:String, fid:String, deletemessage delete:Bool=true) -> Bool{
        do {
            let query = recordTable.filter(userId==uid && friendId==fid)
            let rowid = try recordDB.run(query.delete())
            print("删除消息成功: \(rowid)")
            if delete {
                messageDBStore.deleteMessageByUid(uid, fid: fid)
            }
            
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    
    /**
     删除当前用户所有会话
     
     - parameter uid: 用户唯一表示
     
     - returns: 删除结果
     */
    func deleteAllMessageRecordByUid(uid:String, deletemessage delete:Bool=false) -> Bool{
        do {
            let query = recordTable.filter(uId==uid)
            let rowid = try recordDB.run(query.delete())
            print("删除所有对话成功: \(rowid)")
            if delete {
                messageDBStore.deleteAllMessage()
            }
            
            return true
        } catch {
            print(error)
            return false
        }
    }
    
}
