//
//  CWChatTextParser.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/16.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import YYText

public let kChatTextKeyPhone = "phone"
public let kChatTextKeyURL = "URL"

private struct CWTextParser {
    static let highlightBorder: YYTextBorder = {
        let highlightBorder = YYTextBorder()
        highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0)
        highlightBorder.fillColor = UIColor(hex: "#D4D1D1")
        return highlightBorder
    }()
}

/// 文本处理
class CWChatTextParser: NSObject {
    
    class func parseText(_ text: String,
                         attributes: [NSAttributedStringKey: Any]) -> NSMutableAttributedString? {

        if text.characters.count == 0 {
            return nil
        }
        
        let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        //匹配电话
        self.enumeratePhoneParser(attributedText)
        //匹配 URL
        self.enumerateURLParser(attributedText)
        //匹配 [表情]
        self.enumerateEmotionParser(attributedText)
        
        return attributedText
    }
    
    fileprivate class func enumeratePhoneParser(_ attributedText: NSMutableAttributedString) {
        
        let phonesResults = CWChatTextParseHelper.regexPhoneNumber.matches(in: attributedText.string,
                                                                      options: [.reportProgress],
                                                                        range: attributedText.yy_rangeOfAll())
        
        for phone: NSTextCheckingResult in phonesResults {
            if phone.range.location == NSNotFound && phone.range.length <= 1 {
                continue
            }

            let highlightBorder = CWTextParser.highlightBorder
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(phone.range.location)) == nil) {
                attributedText.yy_setColor(UIColor(hex: "#1F79FD"), range: phone.range)
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(highlightBorder)
                
                let text = attributedText.string as NSString
                let phoneString = text.substring(with: phone.range) as String
                highlight.userInfo = [kChatTextKeyPhone : phoneString]
                attributedText.yy_setTextHighlight(highlight, range: phone.range)
            }
        }
        
    }
    
    
    fileprivate class func enumerateURLParser(_ attributedText: NSMutableAttributedString) {

        let URLsResults = CWChatTextParseHelper.regexURLs.matches(in: attributedText.string,
                                                             options: [.reportProgress],
                                                               range: attributedText.yy_rangeOfAll())

        for URL: NSTextCheckingResult in URLsResults {
            if URL.range.location == NSNotFound && URL.range.length <= 1 {
                continue
            }
            
            let highlightBorder = CWTextParser.highlightBorder
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(URL.range.location)) == nil) {
                attributedText.yy_setColor(UIColor(hex: "#1F79FD"), range: URL.range)
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(highlightBorder)
                
                let text = attributedText.string as NSString
                var URLString = text.substring(with: URL.range) as String
                
                if !URLString.hasPrefix("http://") || !URLString.hasPrefix("https://") {
                    URLString = "http://"+URLString
                }
                
                highlight.userInfo = [kChatTextKeyURL : URLString]
                attributedText.yy_setTextHighlight(highlight, range: URL.range)
            }
        }
        
    }
    
    fileprivate class func enumerateEmotionParser(_ attributedText: NSMutableAttributedString) {

        let emoticonResults = CWChatTextParseHelper.regexEmotions.matches(in: attributedText.string,
                                                                          options: [.reportProgress],
                                                                          range: attributedText.yy_rangeOfAll())
        var emoClipLength: Int = 0
        let text = attributedText.string as NSString
        for emotion: NSTextCheckingResult in emoticonResults {
            if emotion.range.location == NSNotFound && emotion.range.length <= 1 {
                continue
            }
            var range: NSRange  = emotion.range
            range.location -= emoClipLength
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(range.location)) != nil) {
                continue
            }
            if (attributedText.yy_attribute(YYTextAttachmentAttributeName, at: UInt(range.location)) != nil) {
                continue
            }
            
            let fontSize = attributedText.yy_font?.pointSize ?? 16.0
            
            //用来存放字典，字典中存储的是图片和图片对应的位置
            var title = text.substring(with: emotion.range) as String
            let i = title.index(title.startIndex, offsetBy: 1)
            let j = title.index(title.endIndex, offsetBy: -1)
            title = String(title[i..<j])
            
            guard let emotionImage = EmoticonManager.shared.emoticonImage(with: title) else {
                continue
            }
        
            let emojiText = NSMutableAttributedString.yy_attachmentString(withEmojiImage: emotionImage, fontSize: fontSize + 1)
            attributedText.replaceCharacters(in: range, with: emojiText!)
            emoClipLength += range.length - 1
        }        
        
    }
    
    
}

class CWChatTextParseHelper {
    
    /**
     正则：匹配 [哈哈] [笑哭。。] 表情
     */
    class var regexEmotions: NSRegularExpression {
        get {
            let regularExpression = try! NSRegularExpression(pattern: "\\[[^ \\[\\]]+?\\]", options: [.caseInsensitive])
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
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            return regularExpression
        }
    }
    
    /**
     正则：匹配 7-25 位的数字, 010-62104321, 0373-5957800, 010-62104321-230
     */
    class var regexPhoneNumber: NSRegularExpression {
        get {
            let regex = "([\\d]{7,25}(?!\\d))|((\\d{3,4})-(\\d{7,8}))|((\\d{3,4})-(\\d{7,8})-(\\d{1,4}))"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            return regularExpression
        }
    }
}

