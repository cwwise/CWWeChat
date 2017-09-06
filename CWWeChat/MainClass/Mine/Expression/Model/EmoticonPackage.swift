//
//  EmoticonPackage.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

// 一组有序的表情，构成一个表情包。
// 一组有序的表情包，构成一个分区。
/// 表情分区
public class EmoticonZone: NSObject {
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
public class EmoticonPackage: NSObject {
    
    /// 表情作者
    class EmoticonAuthor: NSObject {
        var name: String = ""
        var avatar: URL?
        var banner: URL?
        var userDescription: String = ""
    }
    
    // 标签类型
    var type: EmoticonType = .normal
    
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

extension EmoticonPackage: Resource {
    
    public var downloadURL: URL {
        return cover!
    }
    
    public var cacheKey: String {
        return id
    }
}


