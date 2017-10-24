//
//  MessageLayoutSettings.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import UIKit

public class MessageLayoutSettings {
  
    public static let share = MessageLayoutSettings()
    
    public var messageToTopPadding: CGFloat
    
    public var messageToBottomPadding: CGFloat
    
    // 内容距离左边的距离
    public var contentToLeftPadding: CGFloat
    
    // 头像
    public var avaterSize: CGSize
    // 昵称
    public var usernameSize: CGSize
    
    public var usernameLeftPadding: CGFloat
    
    public var contentTextFont: UIFont
    
    public var errorSize: CGSize
    
    private init() {
        avaterSize = CGSize(width: 40, height: 40)
        
        contentToLeftPadding = 10
        
        messageToTopPadding = 2
        messageToBottomPadding = 10
        
        usernameSize = CGSize(width: 120, height: 20)
        usernameLeftPadding = 10
        
        contentTextFont = UIFont.systemFont(ofSize: 16)
        errorSize = CGSize(width: 15, height: 15)
    }
    
    
}
