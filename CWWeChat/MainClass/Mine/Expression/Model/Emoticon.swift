//
//  Emoticon.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

class Emoticon: NSObject {
    
    enum Image {
        case small
        case big
    }
    
    enum `Type` {
        case gif
        case image
    }
    var id: String
    // 表情类型
    var type: Type = .image
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
}

extension Emoticon: Resource {
    
    var downloadURL: URL {
        return originalUrl!
    }
    
    var cacheKey: String {
        return id
    }
}

