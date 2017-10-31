//
//  ChatBaseStore.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import SQLite

class ChatBaseStore {
    
    /// 当前用户的唯一id，创建数据库名称
    var userId: String
    //MARK: 初始化
    init(userId: String) {
        self.userId = userId
    }
    
    lazy var chatDB: Connection = {
        //数据
        do {
            let chatDB = try Connection(self.path)
            chatDB.busyTimeout = 3
            chatDB.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            return chatDB
        } catch {
            log.error(error)   
            return try! Connection()
        }
    }()

    /// 数据库路径
    lazy var path: String = {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let userPath = "\(documentPath)/\(userId)"
        let path = "\(userPath)/chat/"
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        log.verbose(path)
        return path + "chatmessage.sqlite3"
    }()
    
}
