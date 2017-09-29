//
//  CWChatClientUtil.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/29.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public class CWChatClientUtil {
    
    public static var messageId: String {
        return UUID().uuidString
    }
    
    /// 服务器当前时间
    public static var messageDate: TimeInterval {
        return NSDate().timeIntervalSince1970
    }
    
}
