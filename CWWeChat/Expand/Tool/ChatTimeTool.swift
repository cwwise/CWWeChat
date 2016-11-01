//
//  ChatTimeTool.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/8.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let KTimeFormate:String = "yyyy-MM-dd HH:mm:ss:SSS"
let KMessageTimeFormate:String = "yyyy-MM-dd'T'HH:mm:ss'Z'"


class ChatTimeTool: NSObject {

    static let shareChatTimeTool = ChatTimeTool()
    
    var formatter:DateFormatter = {
       let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    fileprivate override init() {
        super.init()
    }
    
    internal class func stringFromDate(_ date: Date) -> String {
        let formatter = shareChatTimeTool.formatter
        //格式化时间
        formatter.dateFormat = KTimeFormate
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    internal class func dateFromString(_ dateString: String, formatter string: String) -> Date {
        let formatter = shareChatTimeTool.formatter
        //格式化时间
        formatter.dateFormat = string
        let date = formatter.date(from: dateString)
        if date == nil {
            return Date()
        }
        return date!
    }
    
    internal class func stringFromDateString(_ dateString: String, fromDateFormat: String = KMessageTimeFormate, toDateFormat: String = KTimeFormate) -> String? {
        let formatter = shareChatTimeTool.formatter
        //格式化时间
        formatter.dateFormat = fromDateFormat
        let date = formatter.date(from: dateString)
        if (date == nil) {
            return nil
        }
        //转换成当前格式的string
        formatter.dateFormat = toDateFormat
        let dateString = formatter.string(from: date!)
        return dateString
    }
    
    internal class func stringFromDateTimeInterval(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return self.stringFromDate(date)
    }
    
    
    internal class func timeStringFromSinceDate(_ date: Date) -> String {
        //当前时间和消息时间
        let nowDate = Date()
        let messageDate = date
        
        let dateFormatter = shareChatTimeTool.formatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let theDay = dateFormatter.string(from: messageDate)
        let currentDay = dateFormatter.string(from: nowDate)
        
        //当天
        if theDay == currentDay {
            dateFormatter.dateFormat = "ah:mm"
            return dateFormatter.string(from: messageDate)
        }
        //昨天
        else if (dateFormatter.date(from: currentDay)?.timeIntervalSince(dateFormatter.date(from: theDay)!) == 86400) {
            dateFormatter.dateFormat = "ah:mm"
            return "昨天 \(dateFormatter.string(from: messageDate))"
        }
        //一周
        else if (dateFormatter.date(from: currentDay)?.timeIntervalSince(dateFormatter.date(from: theDay)!) == 86400 * 7) {
            dateFormatter.dateFormat = "EEEE ah:mm"
            return dateFormatter.string(from: messageDate)
        }
        //一周之前
        else {
            dateFormatter.dateFormat = "yyyy-MM-dd ah:mm"
            return dateFormatter.string(from: messageDate)

        }
        
    }
    
}
