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
    func pinYingString(_ allFirst:Bool=false) -> String{
        let py=""
        let string = self
        if string == "" {
            return py
        }
        let str = CFStringCreateMutableCopy(nil, 0, string as CFString!)
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
        
//        if allFirst {
//            for x in (str as? String).components(separatedBy: " ") {
//                py += x.pinYingString()
//            }
//        } else {
//            py  = (str as? NSString).substringToIndex(1).uppercased()
//        }
        
        return py
    }
    
    
//    func getFistLetter(str: String)-> String{
//        //转换成可变数据
//        var mutableUserAgent = NSMutableString(string: str) as CFMutableString
//        //let transform = kCFStringTransformMandarinLatin//NSString(string: "Any-Latin; Latin-ASCII; [:^ASCII:] Remove") as CFString
//        //取得带音调拼音
//        if CFStringTransform(mutableUserAgent, nil,kCFStringTransformMandarinLatin, false) == true{
//            //取得不带音调拼音
//            if CFStringTransform(mutableUserAgent,nil,kCFStringTransformStripDiacritics,false) == true{
//                let str1 = mutableUserAgent as String
//                let s = str1.capitalizedString.subString(0, endOffset: -str1.length+1)
//                return s
//            }else{
//                return str
//            }
//        }else{
//            return str
//        }
//    }
    
}

