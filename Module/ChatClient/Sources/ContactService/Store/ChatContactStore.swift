//
//  ChatContactStore.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/27.
//

import Foundation
import SQLite

class ChatContactStore: ChatBaseStore {

    /// 数据库路径
    lazy override var path: String = {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let userPath = "\(documentPath)/\(userId)"
        let path = "\(userPath)/chat/"
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        log.verbose(path)
        return path + "contact.sqlite3"
    }()
}

// MARK: - 增
extension ChatContactStore {

    @discardableResult
    func insert(contactList: [Contact]) -> Bool {

        return true
    }

}
