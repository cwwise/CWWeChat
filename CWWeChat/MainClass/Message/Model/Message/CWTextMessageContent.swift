//
//  CWTextMessageContent.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/5.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 文本消息类定义
class CWTextMessageContent: CWMessageContent {
    
    /// 文本消息内容
    var content: String
    
    ///展示text用的
    lazy var attributeText:NSAttributedString = {
        let attributeText = self.content.messageAttributedString()
        return attributeText
    }()
    
    init(content: String) {
        self.content = content
        super.init()
    }
    
}
