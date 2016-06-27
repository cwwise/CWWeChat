
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
    
}
