//
//  EmoticonDataManager.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SQLite.Swift

/// 数据库管理
class EmoticonManager {
    
    public static let shared = EmoticonManager()

    var userId: String!
    
    private let memoryCache = NSCache<NSString, AnyObject>()

    var localEmoticonList = [String: Emoticon]()
    
    private init() {
        if let qqemoticon = EmoticonGroup(identifier: "com.qq.classic") {
            for item in qqemoticon.emoticons where item.title != nil  {
                localEmoticonList[item.title!] = item
            }
        }
    }
    
    // 主键
    fileprivate let id = Expression<String>("id")

    /// 拓展字端
    fileprivate let ext1 = Expression<String>("ext1")
    
    
    /// 创建数据表

    
    
    
    // MARK: Helper
     
    
    
}


// MARK: 增加
extension EmoticonManager {
    
    func addEmoticonPackage(_ package: EmoticonPackage) {
        
        
        
    }
    
}

// MARK: 查找
extension EmoticonManager {
    
    // 本地用户表情
    func emoticonImage(with title: String) -> UIImage? {
        let key = title as NSString
        if let image = memoryCache.object(forKey: key) as? UIImage {
            return image
        }
    
        guard let emoticon = localEmoticonList[title],
        let path = emoticon.originalUrl?.path,
        let image = UIImage(contentsOfFile: path) else {
            return nil
        }
        
        memoryCache.setObject(image, forKey: key)
        return image
    }
    
    // 获取当前用户的表情包
    func fetchEmoticonPackageList() -> [EmoticonPackage] {
        let packageList = [EmoticonPackage]()
        
    
        return packageList
    }
}

// MARK: 删除
extension EmoticonManager {

    func deleteEmoticonPackage(with id: String) {
        
        
        
    }
    
}



