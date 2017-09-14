//
//  Emoticon.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

public enum EmoticonType: Int {
    case normal
    case big
}

public enum EmoticonFormat: Int {
    case image
    case gif
}

public class Emoticon: NSObject {
    
    var id: String
    // 表情类型
    var type: EmoticonType = .normal
    
    var format: EmoticonFormat = .image

    // 表情size
    var size: CGSize = CGSize.zero
    // 标题
    var title: String?
    // 大图
    var originalUrl: URL?
    // 小图
    var thumbUrl: URL?
    
    init(id: String) {
        self.id = id
    }
    
    convenience init(id: String, title: String, path: URL) {
        self.init(id: id)
        self.title = title
        self.originalUrl = path
    }
    
}

extension Emoticon: Resource {
    
    public var downloadURL: URL {
        return originalUrl!
    }
    
    public var cacheKey: String {
        return id
    }
}

