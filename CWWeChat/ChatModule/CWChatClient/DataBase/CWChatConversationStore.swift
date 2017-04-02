//
//  CWChatConversationStore.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SQLite

/**
 会话管理类
 
 使用SQLite.swift
 */
class CWChatConversationStore: NSObject {

    /// 当前用户的唯一id，创建数据库名称
    var userId: String
    
    let id = Expression<Int64>("id")

    let chat_type = Expression<Int>("chat_type")

    
    lazy var sessionConnection:Connection = {
        do {
            let connection = try Connection(self.path)
            connection.busyTimeout = 3
            connection.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            return connection
        } catch  {
            log.error(error)
            return try! Connection()
        }
    }()
    
    /// 数据库路径
    lazy var path: String = {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = "\(documentPath)/cwchat/\(self.userId)/chat/"
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        log.debug(path)
        return path + "chatsession.sqlite3"
    }()
    
    //MARK: 初始化
    init(userId: String) {
        self.userId = userId
        super.init()
    }
    
}
