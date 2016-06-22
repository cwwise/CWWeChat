//
//  ChatTimeTool.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/8.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let KTimeFormate:String = "yyyy-MM-dd HH:mm:ss:SSS"

class ChatTimeTool: NSObject {

    static let shareChatTimeTool = ChatTimeTool()
    
    var formatter:NSDateFormatter = {
       let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone()
        return formatter
    }()
    
    private override init() {
        super.init()
    }
    
    internal class func stringFromDate(date: NSDate) -> String {
        let formatter = shareChatTimeTool.formatter
        //格式化时间
        formatter.dateFormat = KTimeFormate
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
    
    internal class func stringFromDateString(dateString: String, fromDateFormat: String, toDateFormat: String = KTimeFormate) -> String? {
        let formatter = shareChatTimeTool.formatter
        //格式化时间
        formatter.dateFormat = fromDateFormat
        let date = formatter.dateFromString(dateString)
        if (date == nil) {
            return nil
        }
        //转换成当前格式的string
        formatter.dateFormat = toDateFormat
        let dateString = formatter.stringFromDate(date!)
        return dateString
    }
    
    internal class func stringFromDateTimeInterval(timeInterval: NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: timeInterval)
        return self.stringFromDate(date)
    }
    
    
    internal class func timeStringFromSinceDate(date: NSDate) -> String {
        //当前时间和消息时间
        let nowDate = NSDate()
        let messageDate = date
        
        let dateFormatter = shareChatTimeTool.formatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let theDay = dateFormatter.stringFromDate(messageDate)
        let currentDay = dateFormatter.stringFromDate(nowDate)
        
        //当天
        if theDay == currentDay {
            dateFormatter.dateFormat = "ah:mm"
            return dateFormatter.stringFromDate(messageDate)
        }
        //昨天
        else if (dateFormatter.dateFromString(currentDay)?.timeIntervalSinceDate(dateFormatter.dateFromString(theDay)!) == 86400) {
            dateFormatter.dateFormat = "ah:mm"
            return "昨天 \(dateFormatter.stringFromDate(messageDate))"
        }
        //一周
        else if (dateFormatter.dateFromString(currentDay)?.timeIntervalSinceDate(dateFormatter.dateFromString(theDay)!) == 86400 * 7) {
            dateFormatter.dateFormat = "EEEE ah:mm"
            return dateFormatter.stringFromDate(messageDate)
        }
        //一周之前
        else {
            dateFormatter.dateFormat = "yyyy-MM-dd ah:mm"
            return dateFormatter.stringFromDate(messageDate)

        }
        
    }
    
}
