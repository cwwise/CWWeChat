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
    let momentTable = Table("CWMoment")
    //消息唯一id
    fileprivate let id = Expression<Int64>("id")

    fileprivate let f_momentId = Expression<String>("momentId")
    fileprivate let f_userId = Expression<String>("userId")
    fileprivate let f_username = Expression<String>("username")

    fileprivate let f_momenttype = Expression<Int>("momenttype")
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
    
    lazy var momentDB:Connection = {
        //数据
        do {
            let momentDB = try Connection(self.path)
            momentDB.busyTimeout = 3
            momentDB.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            return momentDB
        } catch {
            log.error(error)
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
            try momentDB.run(momentTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(f_momentId, unique: true)
                t.column(f_userId)
                t.column(f_username)
                t.column(f_momenttype)
                
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
    
    
    func insertMoment(_ moment: CWMoment) {
        

        
    }
    
    func insertMomentList(_ momentList: [CWMoment]) {
        
        do {
            try momentDB.transaction {
                for moment in momentList {
                    
                    // 插入之前 需要判断是否存在，如果存在 则更新一些必要数据
                    
                    let imagename = ""
                    let videoname = ""
                    let timestamp = 123
                    let insert = self.momentTable.insert(self.f_momentId <- moment.momentId,
                                                        self.f_userId <- moment.userId,
                                                        self.f_username <- moment.username,
                                                        self.f_momenttype <- moment.type.rawValue,
                                                        self.f_imagename <- imagename,
                                                        self.f_videoname <- videoname,
                                                        self.f_content <- moment.content ?? "",
                                                        self.f_timestamp <- timestamp,
                                                        
                                                        self.f_sendSuccess <- moment.sendSuccess,
                                                        self.f_isRead <- moment.isRead,
                                                        self.f_isDelete <- moment.isDelete,
                                                        self.f_isPraise <- moment.isPraise
                                                        )
                    try self.momentDB.run(insert)
                }
            }
        } catch {
            log.error(error)
        }
        
        
    }
    
    
}
