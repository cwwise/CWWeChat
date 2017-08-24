//
//  EmoticonPackage.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

// 一组有序的表情，构成一个表情包。
// 一组有序的表情包，构成一个分区。
/// 表情分区
class EmoticonZone: NSObject {
    var name: String
    // 表情包
    var packageList: [EmoticonPackage]
    
    var count: Int {
        return packageList.count
    }
    
    subscript(index: Int) -> EmoticonPackage {
        return packageList[index]
    }
    
    init(name: String, packageList: [EmoticonPackage]) {
        self.name = name
        self.packageList = packageList
    }
}

/// 表情包
class EmoticonPackage: NSObject {
    
    /// 表情作者
    class EmoticonAuthor: NSObject {
        var name: String = ""
        var avatar: String = ""
        var banner: String = ""
        var userDescription: String = ""
    }
    
    // id
    var id: String
    // 表情包名称
    var name: String
    // 副标题
    var subTitle: String?
    
    // 更新时间
    var updated_at: String?
    
    var cover: URL?
    // banner url 
    var banner: URL?
    // 作者
    var author: EmoticonAuthor?
    // 表情数组
    var emoticonList: [Emoticon] = []
    
    // MARK: 表情逻辑
    var downloadSuccess: Bool = false
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
}


