//
//  CWEmoji.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWEmoji: NSObject {
    
    weak var group: CWEmojiGroup?
    
    var type: CWEmojiType
    var chs: String?
    var png: String?
    ///表情图片的路径
    var code: String?

    convenience init(emoji code: String) {
        self.init(code: code, type: .emoji)
    }
    
    convenience init(image chs: String, png: String) {
        self.init(chs: chs, png: png, type: .image)
    }
    
    private init(chs: String? = nil, png: String? = nil, code: String? = nil, type: CWEmojiType) {
        self.chs = chs
        self.png = png
        self.type = type
        self.code = code
    }
    
}
