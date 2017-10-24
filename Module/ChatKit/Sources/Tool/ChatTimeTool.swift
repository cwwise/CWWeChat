//
//  ChatTimeTool.swift
//  ChatKit
//
//  Created by wei chen on 2017/10/24.
//

import Foundation
import UIKit

class ChatTimeTool {
    
    static let share = ChatTimeTool()
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    private init() {
        
    }
    
    class func chatTimeString(from date: Date) -> String {
        //当前时间和消息时间
        let nowDate = Date()
        let messageDate = date
        
        let dateFormatter = ChatTimeTool.share.formatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let theDay = dateFormatter.string(from: messageDate)
        let currentDay = dateFormatter.string(from: nowDate)
        
        //当天
        if theDay == currentDay {
            dateFormatter.dateFormat = "ah:mm"
            return dateFormatter.string(from: messageDate)
        }
        //昨天
        else if (nowDate.timeIntervalSince(date) <= 86400) {
            dateFormatter.dateFormat = "ah:mm"
            return "昨天 \(dateFormatter.string(from: messageDate))"
        }
        //一周
        else if (nowDate.timeIntervalSince(date) <= 86400 * 7) {
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
