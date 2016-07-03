//
//  CWChatDBMessageStore.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/27.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SQLite

/**
 消息管理类
 
 使用SQLite.swift
 
 可以[查看sql](https://github.com/stephencelis/SQLite.swift/issues/399)
 
 */
class CWChatDBMessageStore: NSObject {

    typealias ChatHistoryMessagesHandle = ([CWMessageProtocol], NSDate,Bool) -> ()
    typealias InsertMessageAction = (Bool) -> ()

    // TODO: 修改名称避免过程中的问题,需要修改一些变量名称
    /// 当前用户的唯一id，创建数据库名称
    var current_userId: String
    
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
    //用户唯一id
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
        let path = "\(documentPath)/User/\(self.current_userId)/Chat/DB/"
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        CWLogDebug(path)
        return path.stringByAppendingString("chatmessage.sqlite3")
    }()
    
    //MARK: 初始化
    init(userId: String) {
        self.current_userId = userId
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
    func appendMessage(message: CWMessageProtocol, complete: InsertMessageAction) {
        
        guard let userID = message.messageSendId, let friendID = message.messageReceiveId else {
            CWLogError("插入消息失败: 消息体缺少参数, \(message.messageID)")
            dispatch_async_safely_to_main_queue({ 
                complete(false)
            })
            return
        }
        //时间
        let dataString = "\(message.messageSendDate.timeIntervalSince1970)"
        do {
//            let jsonData = try! NSJSONSerialization.dataWithJSONObject(message.contentInfo!, options: .PrettyPrinted)
//            let strJson = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as? String ?? ""
            let sql = messageTable.insert(messageid <- message.messageID,
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
                ext1 <- "")
            
            try messageDB.run(sql)
            CWLogDebug("插入消息成功: \(message.messageID)")
            recordDBStore.addRecordByMessage(message, needUnread: message.messageOwnerType != .Myself)
        } catch {
            CWLogDebug("插入消息失败: \(error), \(message.messageID)")
            dispatch_async_safely_to_main_queue({
                complete(false)
            })
            
        }
        dispatch_async_safely_to_main_queue({
            complete(true)
        })
    }
}

extension CWChatDBMessageStore {
    
    //MARK: 查询消息
    /**
     查询用户聊天数据
     
     - parameter userID:    用户id
     - parameter partnerID: 朋友id
     - parameter fromDate:  开始时间
     - parameter count:     开始条数
     - parameter handle:    消息查询结果
     */
    func messagesByUserID(userID:String, partnerID:String, fromDate:NSDate, count:Int = 30 ,handle:ChatHistoryMessagesHandle) {
        
        let dateInterval = "\(fromDate.timeIntervalSince1970)"
        let query = messageTable.filter(uId == userID && friendId==partnerID && date < dateInterval).order(date.desc).limit(count)
        do {
            let count = messageDB.scalar(messageTable.filter(uId == userID && friendId==partnerID).count)
            let result = try messageDB.prepare(query)
            
            var listData = [CWMessageProtocol]()
            //需要反转，得到正确的顺序
            for row in result.reverse() {
                let message = createDBMessageByFMResult(row)
                listData.append(message)
            }
            
            handle(listData, fromDate ,listData.count > count)
        } catch {
            CWLogError("查询消息失败: \(error)")
        }
        
    }
    
    /**
     根据用户id和朋友的id获取最后一天消息
     
     - parameter userID:    用户唯一标示
     - parameter partnerID: 对方唯一标示
     
     - returns: 最后一个消息对象
     */
    func lastMessageByUserID(userID:String, partnerID:String) -> CWMessageProtocol? {
        let query = messageTable.filter(uId == userID && friendId==partnerID).order(date.desc).limit(1)
        if let row = messageDB.pluck(query) {
            let message = createDBMessageByFMResult(row)
            return message
        } else {
            return nil
        }
    }
    
    /**
     根据结果返回消息的数组
     
     - parameter result: 数据库返回的数据结果 SQLite.Row
     
     - returns: 消息的数组
     */
    func createDBMessageByFMResult(row:Row) -> CWMessageProtocol {
        
//        let type = CWMessageType(rawValue: row[msg_type])!
        let message = CWMessageModel()
        message.messageID = row[messageid]
        message.messageSendId = row[uId]
        message.messageReceiveId = row[friendId]
        
        message.messageSendDate = NSDate(timeIntervalSince1970: Double(row[date])!)
        message.chatType = CWChatType(rawValue: row[chat_type])!
        message.messageType = CWMessageType(rawValue: row[msg_type])!
        message.messageOwnerType = CWMessageOwnerType(rawValue: row[own_type])!
        
        message.messageSendState = CWMessageSendState(rawValue: row[send_status])!
//        message.messageReadState = ChatMessageReadState(rawValue: row[received_status])!
        
//        message.messagePlayState = ChatMessagePlayState(state: row[play_status])
//        message.messageUploadState = ChatMessageUploadState(rawValue: row[upload_status])!
        
        
        let string = row[content]! as String
//        let infoJson = JSON(data: string.dataUsingEncoding(NSUTF8StringEncoding)!)
//        message.contentInfo = infoJson.dictionaryObject
        message.content = string
        
        return message
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
        let query = messageTable.filter(uId == uid && friendId == fid)
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
