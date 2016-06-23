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
    func pinYingString(allFirst:Bool=false) -> String{
        var py=""
        let string = self
        if string == "" {
            return py
        }
        let str = CFStringCreateMutableCopy(nil, 0, string)
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
        if allFirst {
            for x in (str as String).componentsSeparatedByString(" ") {
                py += x.pinYingString()
            }
        } else {
            py  = (str as NSString).substringToIndex(1).uppercaseString
        }
        
        return py
    }
}

