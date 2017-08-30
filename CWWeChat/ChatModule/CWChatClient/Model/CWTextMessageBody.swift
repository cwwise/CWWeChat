//
//  CWTextMessageObject.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

class CWTextMessageBody: NSObject, CWMessageBody {

    weak var message: CWMessage?
    /// 消息体类型
    var type: CWMessageType = .text
    /// 文本内容
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

extension CWTextMessageBody {
    
    var messageEncode: String {
        return text
    }
    
    func messageDecode(string: String) {
        self.text = string
    }
}
