//
//  CWEmoji.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWEmoticon: NSObject {
    
    var type: CWEmoticonType
    var chs: String?
    var png: String?
    var gif: String?

    ///表情图片的路径
    var code: String?

    convenience init(code: String) {
        self.init(code: code, type: .emoji)
    }
    
    convenience init(chs: String, png: String) {
        self.init(chs: chs, png: png, type: .image)
    }
    
    convenience init(express chs: String, png: String, gif: String) {
        self.init(chs: chs, png: png, gif: gif, type: .expression)
    }
    
    private init(chs: String? = nil,
                 png: String? = nil,
                 code: String? = nil,
                 gif: String? = nil,
                 type: CWEmoticonType) {
        self.chs = chs
        self.png = png
        self.type = type
        self.code = code
    }
    
}
