//
//  Database.swift
//  ChatClient
//
//  Created by chenwei on 2018/3/21.
//

import Foundation
import SQLite
import SQLiteMigrationManager

/// 数据库版本升级
struct DatabaseMigration {
    let db: Connection
    let migrationManager: SQLiteMigrationManager
    
    init?(path: String) {
        do {
            self.db = try Connection(path)
        } catch {
            return nil
        }
        self.migrationManager = SQLiteMigrationManager(db: self.db, migrations: DatabaseMigration.migrations(), bundle: nil)
    }
    
    func migrateIfNeeded() throws {
        if !migrationManager.hasMigrationsTable() {
            try migrationManager.createMigrationsTable()
        }
        
        if migrationManager.needsMigration() {
            try migrationManager.migrateDatabase()
        }
    }
}

extension DatabaseMigration {
    
    static func migrations() -> [Migration] {
        return [MigrationVersion1()]
    }
    
}
