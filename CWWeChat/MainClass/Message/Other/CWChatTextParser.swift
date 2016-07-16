//
//  CWChatTextParser.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/16.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

public let kChatTextKeyPhone = "phone"
public let kChatTextKeyURL = "URL"

class CWChatTextParser: NSObject {
    
    class func parseText(text: String, font: UIFont) -> NSMutableAttributedString? {

        if text.characters.count == 0 {
            return nil
        }
        let length = text.characters.count
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedText.addAttributes([NSFontAttributeName: font,
                            NSForegroundColorAttributeName: UIColor.blackColor()],
                                     range: NSRange(location: 0, length: length))
        
        //匹配电话
        self.enumeratePhoneParser(attributedText)
        //匹配 URL
        self.enumerateURLParser(attributedText)
        //匹配 [表情]
        self.enumerateEmotionParser(attributedText, fontSize: font.pointSize)
        
        return attributedText
        
    }
    
    
    private class func enumeratePhoneParser(attributedText: NSMutableAttributedString) {
        
        let phonesResults = CWChatTextParseHelper.regexPhoneNumber.matchesInString(
            attributedText.string,
            options: [.ReportProgress],
            range: attributedText.rangeOfAll()
        )
        
        for phone: NSTextCheckingResult in phonesResults {
            if phone.range.location == NSNotFound && phone.range.length <= 1 {
                continue
            }
            
            attributedText.addAttributes([NSForegroundColorAttributeName: UIColor(hexString: "#1F79FD")], range: phone.range)
        }
        
    }
    
    
    private class func enumerateURLParser(attributedText: NSMutableAttributedString) {

        let URLsResults = CWChatTextParseHelper.regexURLs.matchesInString(
            attributedText.string,
            options: [.ReportProgress],
            range: attributedText.rangeOfAll()
        )
        
        for URL: NSTextCheckingResult in URLsResults {
            if URL.range.location == NSNotFound && URL.range.length <= 1 {
                continue
            }
            
            attributedText.addAttributes([NSForegroundColorAttributeName: UIColor(hexString: "#1F79FD")], range: URL.range)
        }
        
    }
    
    private class func enumerateEmotionParser(attributedText: NSMutableAttributedString, fontSize: CGFloat) {

        
    }
    
    
}




class CWChatTextParseHelper {
    
    /**
     正则：匹配 [哈哈] [笑哭。。] 表情
     */
    class var regexEmotions: NSRegularExpression {
        get {
            let regularExpression = try! NSRegularExpression(pattern: "\\[[^\\[\\]]+?\\]", options: [.CaseInsensitive])
            return regularExpression
        }
    }
    
    /**
     正则：匹配 www.a.com 或者 http://www.a.com 的类型
     
     ref: http://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url
     */
    class var regexURLs: NSRegularExpression {
        get {
            let regex: String = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|^[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)+([-A-Z0-9a-z_\\$\\.\\+!\\*\\(\\)/,:;@&=\\?~#%]*)*"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
            return regularExpression
        }
    }
    
    /**
     正则：匹配 7-25 位的数字, 010-62104321, 0373-5957800, 010-62104321-230
     */
    class var regexPhoneNumber: NSRegularExpression {
        get {
            let regex = "([\\d]{7,25}(?!\\d))|((\\d{3,4})-(\\d{7,8}))|((\\d{3,4})-(\\d{7,8})-(\\d{1,4}))"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
            return regularExpression
        }
    }
}


private extension NSAttributedString {
    
    func rangeOfAll() -> NSRange {
        return NSRange(location: 0, length: self.length)
    }
}


private extension String {
    
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
    
    func RangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }
}

