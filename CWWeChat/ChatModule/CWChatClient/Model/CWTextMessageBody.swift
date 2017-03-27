//
//  CWTextMessageObject.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

class CWTextMessageBody: NSObject, CWMessageBody {

    weak var message: CWChatMessage?
    /// 文本内容
    var text: String
    /// 消息体类型
    var type: CWMessageType = .text
    
    init(text: String, message: CWChatMessage? = nil) {
        self.text = text
    }
    
    
    
}
