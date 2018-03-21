//
//  StoreMigration.swift
//  ChatClient
//
//  Created by chenwei on 2018/3/21.
//

import Foundation
import SQLiteMigrationManager
import SQLite.Swift

/// 版本升级所需要的
struct MigrationVersion1: Migration {
    var version: Int64 = 2017_12_19_22_43_30
    
    func migrateDatabase(_ db: Connection) throws {
        
        /// 如果不存在表 则不需要操作 会重新创建
        if db.tableExists(tableName: "contact") == false {
            return
        }
        
    }
}

extension Connection {
    /// 判断table是否存在
    func tableExists(tableName: String) -> Bool {
        do {
            let sql = "SELECT EXISTS (SELECT * FROM sqlite_master WHERE type = 'table' AND name = ?)"
            let count = try self.scalar(sql, tableName) as? Int64 ?? 0
            return count > 0
        } catch {
            return false
        }
    }
}
