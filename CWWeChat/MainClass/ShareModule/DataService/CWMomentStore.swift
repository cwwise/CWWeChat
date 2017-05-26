//
//  CWMomentStore.swift
//  CWWeChat
//
//  Created by wei chen on 2017/5/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SQLite.Swift

class CWMomentStore: NSObject {

    static let share = CWMomentStore()
    // 添加前缀 field
    //MARK: 数据库属性
    let shareTable = Table("CWMoment")
    //消息唯一id
    fileprivate let id = Expression<Int64>("id")

    fileprivate let f_shareId = Expression<String>("shareId")
    fileprivate let f_userId = Expression<String>("userId")
    fileprivate let f_username = Expression<String>("username")

    fileprivate let f_sharetype = Expression<Int>("sharetype")
    //
    fileprivate let f_imagename = Expression<String>("imagename")
    fileprivate let f_videoname = Expression<String>("videoname")
    fileprivate let f_content = Expression<String>("content")
    /// 时间戳
    fileprivate let f_timestamp = Expression<Int>("timestamp")

    // 是否发送成功，争对上传
    fileprivate let f_sendSuccess = Expression<Bool>("sendSuccess")
    fileprivate let f_isRead = Expression<Bool>("isRead")
    fileprivate let f_isPraise = Expression<Bool>("isPraise")
    fileprivate let f_isDelete = Expression<Bool>("isDelete")
    
    private override init() {
        super.init()
    }
    
    lazy var shareDB:Connection = {
        //数据
        do {
            let shareDB = try Connection(self.path)
            shareDB.busyTimeout = 3
            shareDB.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            return shareDB
        } catch {
            print(error)
            return try! Connection()
        }
    }()
    
    /// 数据库路径
    lazy var path: String = {
        let userPath = CWChatClient.share.userFilePath
        let path = "\(userPath)/chat/"
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        log.verbose(path)
        return path + "share.sqlite3"
    }()
    
    // 创建数据库
    func createMessageTable() {
        do {
            try shareDB.run(shareTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(f_shareId, unique: true)
                t.column(f_userId)
                t.column(f_username)
                t.column(f_sharetype)
                
                t.column(f_imagename)
                t.column(f_videoname)
                t.column(f_content)
    
                t.column(f_timestamp)

                t.column(f_sendSuccess)
                t.column(f_isRead)
                t.column(f_isPraise)
                t.column(f_isDelete)
            })

        } catch {
            log.error(error)
        }
    }
    
    
    func insertShare(_ share: CWMoment) {
        

        
    }
    
    func insertShareList(_ shareList: [CWMoment]) {
        
        do {
            try shareDB.transaction {
                for share in shareList {
                    
                    // 插入之前 需要判断是否存在，如果存在 则更新一些必要数据
                    
                    let imagename = ""
                    let videoname = ""
                    let timestamp = 123
                    let insert = self.shareTable.insert(self.f_shareId <- share.shareId,
                                                        self.f_userId <- share.userId,
                                                        self.f_username <- share.username,
                                                        self.f_sharetype <- share.shareType.rawValue,
                                                        self.f_imagename <- imagename,
                                                        self.f_videoname <- videoname,
                                                        self.f_content <- share.content ?? "",
                                                        self.f_timestamp <- timestamp,
                                                        
                                                        self.f_sendSuccess <- share.sendSuccess,
                                                        self.f_isRead <- share.isRead,
                                                        self.f_isDelete <- share.isDelete,
                                                        self.f_isPraise <- share.isPraise
                                                        )
                    try self.shareDB.run(insert)
                }
            }
        } catch {
            log.error(error)
        }
        
        
    }
    
    
}
