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

    ///消息数据库的单利
    var recordDBStore:CWChatDBRecordStore = {
        return CWChatDBDataManager.sharedInstance.dbRecordStore
    }()
    
    //MARK: 数据库属性
    let messageTable = Table("message")
    //消息唯一id
    let id = Expression<Int64>("id")
    //
    let messageid = Expression<String>("msgid")
    let userId = Expression<String>("uid")
    let friendId = Expression<String>("fid")
    //时间
    let date = Expression<String>("date")
    /// 单聊群聊
    let partner_type = Expression<Int>("partner_type")
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
    
    lazy var path: String = {
        let documentPath = NSHomeDirectory().stringByAppendingString("/Documents")
        let path = "\(documentPath)/User/\(self.userId)/Chat/DB/"
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        return path.stringByAppendingString("chatmessage.sqlite3")
        
    }()
    
    private override init() {
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
                t.column(userId)
                t.column(friendId)
                t.column(date)
                
                t.column(partner_type, defaultValue: 0)
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
    
    
}
