//
//  EmoticonDataManager.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SQLite.Swift

protocol EmoticonDataManager {
    
    
    
}

/// 数据库管理
class EmoticonStore: EmoticonDataManager {
    
    public static let shared = EmoticonStore()

    var userId: String!
    
    private init() {
        
    }
    
    // 主键
    fileprivate let id = Expression<String>("id")

    /// 拓展字端
    fileprivate let ext1 = Expression<String>("ext1")
    
    
    /// 创建数据表

    
    
    
    // MARK: Helper
     
    
    
}


// MARK: 增加
extension EmoticonDataManager {
    
    func addEmoticonPackage(_ package: EmoticonPackage) {
        
        
        
    }
    
}

// MARK: 查找
extension EmoticonDataManager {
    
    // 获取当前用户的表情包
    func fetchEmoticonPackageList() -> [EmoticonPackage] {
        var packageList = [EmoticonPackage]()
        
        
        
        
        return packageList
    }
    
    
    
}

// MARK: 删除
extension EmoticonDataManager {

    func deleteEmoticonPackage(with id: String) {
        
        
        
    }
    
}



