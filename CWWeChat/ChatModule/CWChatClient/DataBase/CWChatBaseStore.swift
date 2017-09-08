//
//  CWChatBaseStore.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SQLite

class CWChatBaseStore: NSObject {
    /// 当前用户的唯一id，创建数据库名称
    var userId: String
    //MARK: 初始化
    init(userId: String) {
        self.userId = userId
        super.init()
    }
    
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
        return path + "chatmessage.sqlite3"
    }()
    
    
}
