//
//  NSString+Chat.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/24.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

extension String {
    
    public static func UUIDString() -> String {
        let uuid = NSUUID().UUIDString
        let uuidString = uuid.stringByReplacingOccurrencesOfString("-", withString: "")
        return uuidString
    }
    
    public func trimWhitespace() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    public func numberOfLines() -> Int {
        return self.componentsSeparatedByString("\n").count+1
    }
    
    
}