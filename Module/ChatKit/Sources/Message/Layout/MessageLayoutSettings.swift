//
//  MessageLayoutSettings.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import UIKit

public class MessageLayoutSettings {

    public static var share = MessageLayoutSettings()
    
    public var kMessageToLeftPadding: CGFloat
    
    public var kMessageToTopPadding: CGFloat
    
    public var kMessageToBottomPadding: CGFloat
    
    // 头像
    public var kAvaterSize: CGSize
    // 昵称
    public var kUsernameSize: CGSize
    
    public var kUsernameLeftPadding: CGFloat
    
    public var contentTextFont: UIFont
    
    public var errorSize: CGSize
    
    private init() {
        kAvaterSize = CGSize(width: 40, height: 40)
        kMessageToLeftPadding = 10
        kMessageToTopPadding = 10
        kMessageToBottomPadding = 10
        
        kUsernameSize = CGSize(width: 120, height: 20)
        kUsernameLeftPadding = 10
        
        contentTextFont = UIFont.systemFont(ofSize: 16)
        
        errorSize = CGSize(width: 15, height: 15)
    }
    
    
}
