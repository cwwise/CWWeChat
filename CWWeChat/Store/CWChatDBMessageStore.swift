//
//  CWChatDBMessageStore.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/27.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SQLite

class CWChatDBMessageStore: NSObject {

    /// 当前用户的唯一id，创建数据库名称
    var userId: String
    
    ///消息数据库的单利
    lazy var recordDBStore:CWChatDBRecordStore = {
        return CWChatDBDataManager.sharedInstance.dbRecordStore
    }()
    
    //MARK: 数据库属性
    let messageTable = Table("message")
    //消息唯一id
    let id = Expression<Int64>("id")
    //
    let messageid = Expression<String>("msgid")
    let uId = Expression<String>("uid")
    let friendId = Expression<String>("fid")
    //时间
    let date = Expression<String>("date")
    /// 单聊群聊
    let chat_type = Expression<Int>("partner_type")
    /// 所属人
    let own_type = Expression<Int>("own_type")
    /// 消息类型
    let msg_type = Expression<Int>("msg_type")
    /// 内容
    let content = Expression<String?>("content")
    ///接收状态
    let send_status = Expression<Int>("send_status")
    ///发送状态
    let received_status = Expression<Int>("received_status")
    /// 播放状态
    let play_status = Expression<Bool>("play_status")
    /// 上传状态
    let upload_status = Expression<Int>("upload_status")
    
    let ext1 = Expression<String?>("ext1")
    
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
        let documentPath = NSHomeDirectory().stringByAppendingString("/Documents")
        let path = "\(documentPath)/User/\(self.userId)/Chat/DB/"
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        return path.stringByAppendingString("chatmessage.sqlite3")
    }()
    
    //MARK: 初始化
    init(userId: String) {
        self.userId = userId
        super.init()
        createMessageTable()
    }
    
    //MARK: 创建表
    /**
     创建message数据表
     */
    func createMessageTable() {
        
        do {
            
            try messageDB.run(messageTable.create(ifNotExists: true) { t in
                
                t.column(id, primaryKey: .Autoincrement)
                t.column(messageid, unique: true)
                t.column(uId)
                t.column(friendId)
                t.column(date)
                
                t.column(chat_type, defaultValue: 0)
                t.column(own_type, defaultValue: 0)
                t.column(msg_type, defaultValue: 0)
                
                t.column(content, defaultValue: "")
                
                t.column(send_status, defaultValue: 0)
                t.column(received_status, defaultValue: 0)
                
                t.column(play_status, defaultValue: false)
                t.column(upload_status, defaultValue: 0)
                
                t.column(ext1, defaultValue: "")
                })
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    /**
     添加消息
     
     - parameter message: 消息体
     
     - returns: 添加消息的结果
     */
    func addMessage(message: CWMessageProtocol) -> Bool {
        
        guard let userID = message.messageSendId, let friendID = message.messageReceiveId else {
            print("插入消息失败: 消息体缺少参数, \(message.messageID)")
            return false
        }
        //时间
        let dataString = "\(message.messageSendDate.timeIntervalSince1970)"
        do {
//            let jsonData = try! NSJSONSerialization.dataWithJSONObject(message.contentInfo!, options: .PrettyPrinted)
//            let strJson = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as? String ?? ""
            let rowid = try messageDB.run(messageTable.insert(messageid <- message.messageID,
                uId <- userID,
                friendId <- friendID,
                date <- dataString,
                chat_type <- message.chatType.rawValue,
                own_type <- message.messageOwnerType.rawValue,
                msg_type <- message.messageType.rawValue,
                content <- message.content,
                send_status <- message.messageSendState.rawValue,
//                received_status <- message.messageReadState.rawValue,
//                upload_status <- message.messageUploadState.rawValue,
                ext1 <- ""))
            CWLogDebug("插入消息成功: \(rowid), \(message.messageID)")
            
            recordDBStore.addRecordByMessage(message, needUnread: message.messageOwnerType != .Myself)
            
        } catch {
            print("插入消息失败: \(error), \(message.messageID)")
            return false
        }
        return true
    }
    

    
}

extension CWChatDBMessageStore {
    //MARK: 删除消息数据
    /**
     删除一条消息
     
     - parameter messageID: 消息唯一的id messageID
     */
    func deleteMessageByMessageID(messageID:String) -> Bool {
        let query = messageTable.filter(messageID == messageid)
        do {
            let rowid = try messageDB.run(query.delete())
            print("删除消息成功: \(rowid), \(messageID)")
            return true
        } catch {
            print("删除消息失败: \(error)")
            return false
        }
    }
    
    /**
     删除当前用户指定人的聊天记录
     
     - parameter uid: 用户id
     - parameter fid: 朋友id
     
     - returns: 删除消息的结果
     */
    func deleteMessageByUid(uid:String, fid:String) -> Bool {
        let query = messageTable.filter(userId == uid && friendId == fid)
        do {
            let rowid = try messageDB.run(query.delete())
            print("删除消息成功: \(rowid)")
            return true
        } catch {
            print("删除消息失败: \(error)")
            return false
        }
    }
    
    /**
     删除所有聊天记录
     */
    func deleteAllMessage() {
        do {
            try messageDB.run(messageTable.delete())
        } catch {
            print(error)
        }
    }
}
