//
//  ChatClientError.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public class ChatClientError {
    public var code: Int
    // 描述
    public var error: String
    
    init(code: Int = 0, error: String) {
        self.code = code
        self.error = error
    }
}
