//
//  CWTextMessageObject.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

class CWTextMessageObject: NSObject {

    weak var message: CWChatMessage?
    
    var text: String = ""
    
    var type: CWMessageType = .text
    
    init(message: CWChatMessage) {
        self.message = message
    }
    
    
    
}
