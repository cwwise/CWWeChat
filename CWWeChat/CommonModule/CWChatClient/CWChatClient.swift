//
//  CWChatClient.swift
//  CWWeChat
//
//  Created by chenwei on 2017/2/12.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit


/// 聊天核心单利
class CWChatClient: NSObject {
    
    private static let share = CWChatClient()

    private override init() {
        super.init()
        
        _ = FileManager.default
        
    }
    
    
    
}
