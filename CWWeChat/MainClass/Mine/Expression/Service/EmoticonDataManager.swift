//
//  EmoticonDataManager.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol DataManager {
    
}

/// 数据库管理
class EmoticonDataManager: DataManager {
    
    public static let shared = EmoticonDataManager()
    
    var userId: String!
    
    private init() {
        
        
        
    }
    
    
    
    
    
    
}
