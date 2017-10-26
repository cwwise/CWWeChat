//
//  ChatKitUtil.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import Foundation

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenScale = UIScreen.main.scale

let kChatTextMaxWidth = kScreenWidth * 0.58
//图片
let kChatImageMaxWidth = kScreenWidth * 0.45
let kChatImageMinWidth = kScreenWidth * 0.25

let kChatVoiceMaxWidth = kScreenWidth * 0.3

let kChatKitAssetBundle = Bundle.chatKitAssetBundle()

struct ChatCellUI {
    
    static let bubbleTopMargin: CGFloat = 2
    static let bubbleBottomMargin: CGFloat = 11
    
    static let left_cap_insets   = UIEdgeInsets(top: 32, left: 40, bottom: 20, right: 40)
    /// 左边气泡背景区域 间距
    static let left_edge_insets  = UIEdgeInsets(top: 2+10, left: 17, bottom: 11+9.5, right: 17)
    
    static let right_cap_insets  = UIEdgeInsets(top: 32, left: 40, bottom: 20, right: 40)
    /// 右边气泡背景区域 间距
    static let right_edge_insets = UIEdgeInsets(top: 2+10, left: 17, bottom: 11+9.5, right: 17)
}


class ChatKitUtil {
    
    
    
    
}


class MessageTimeUtil {
    var maxMessageCount: Int = 15
    var lastMessageTime: TimeInterval?
    var messageMaxInterval: TimeInterval = 60*3
    var currentCount: Int = 0
    
    func handleMessage(_ message: MessageModel) {
        
        currentCount += 1
        // 先判断消息的时间间隔
        guard let messageTime = lastMessageTime else {
            message.showTime = true
            lastMessageTime = message.timestamp
            return
        }
        
        lastMessageTime = message.timestamp
        // 先判断消息时间间隔
        if message.timestamp - messageTime > messageMaxInterval {
            message.showTime = true
            return
        }
        
        if currentCount > maxMessageCount {
            message.showTime = true
            currentCount = 0
        }
        
    }
}









