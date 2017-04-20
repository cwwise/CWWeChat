//
//  NSString+Chat.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/24.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension String {
    
    public static func UUIDString() -> String {
        let uuid = UUID().uuidString
        return uuid
    }
    
    public func trimWhitespace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func numberOfLines() -> Int {
        return self.components(separatedBy: "\n").count+1
    }
    
}
