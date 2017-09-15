//
//  NSString+PinYin.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit

extension String {
    // 拼音
    var pinYingString: String {
        let str = NSMutableString(string: self) as CFMutableString
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        
        let string = str as String
        return string.capitalized.trimWhitespace()
    }
    
    // 首字母
    var pinyingInitial: String {
        let array = self.capitalized.components(separatedBy: " ")
        var pinYing = ""
        for temp in array {
            if temp.characters.count == 0 {continue}
            let index = temp.index(temp.startIndex, offsetBy: 1)
            pinYing += temp[..<index]
        }
        return pinYing
        
    }
    
    var fistLetter: String {
        if self.characters.count == 0 {return self}
        let index = self.index(self.startIndex, offsetBy: 1)
        return String(self[..<index])
    }
}

