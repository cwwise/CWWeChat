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
        let uuid = NSUUID().UUIDString
        return uuid
    }
    
    public func trimWhitespace() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    public func numberOfLines() -> Int {
        return self.componentsSeparatedByString("\n").count+1
    }
    
    
    ///发送聊天的attributedString
    public func messageAttributedString() -> NSAttributedString {
        
        //1.创建可变的属性字符串
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttributes([NSFontAttributeName:UIFont.fontTextMessageText()],
                                      range: NSMakeRange(0, self.characters.count))
        
        let regex_emoji = "\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"
        do {
            let re = try NSRegularExpression(pattern: regex_emoji, options: .CaseInsensitive)
            let resultArray = re.matchesInString(self, options: .ReportProgress, range: NSMakeRange(0, self.characters.count))
            //3、获取所有的表情以及位置
            //用来存放字典，字典中存储的是图片和图片对应的位置
            var imageArray = Array<[String:AnyObject]>()
            
            //根据匹配范围来用图片进行相应的替换
            for match in resultArray {
                //获取数组元素中得到range
                let range = match.range
                let stringRange = Range(self.startIndex.advancedBy(range.location)..<self.startIndex.advancedBy(range.location+range.length))
                
                //获取原字符串中对应的值
                let subStr = self.substringWithRange(stringRange)
                
                let group = CWChatEmojiGroup()
                for emoji in group.emojiData {
                    
                    if (emoji.title == subStr) {
                        //新建文字附件来存放我们的图片,iOS7才新加的对象
                        let textAttachment = NSTextAttachment()
                        textAttachment.image = UIImage(named: emoji.title!)
                        //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                        textAttachment.bounds = CGRectMake(0, -4, 20, 20)
                        //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                        let imageStr = NSAttributedString(attachment: textAttachment)
                        //把图片和图片对应的位置存入字典中
                        let imageDic = ["image":imageStr,
                                        "range":NSValue(range: range)]
                        //把字典存入数组中
                        imageArray.append(imageDic)
                        
                    }
                }
            }
            
            for imageDict in imageArray.reverse() {
                let range = imageDict["range"]?.rangeValue
                attributeString.replaceCharactersInRange(range!, withAttributedString: imageDict["image"] as! NSAttributedString)
            }
            
            
        } catch let error as NSError {
            print(error.description)
            return attributeString
        }
        
        return attributeString
    }
    
}