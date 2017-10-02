//
//  ChatClientUtil.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class ChatClientUtil: NSObject {
    
    static var messageId: String {
        let uuid = UUID().uuidString
        return uuid
    }
    
    static var currentTime: TimeInterval {
        let date = Date()
        return date.timeIntervalSince1970
    }
    
}
