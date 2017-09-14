//
//  CWMessageLayoutSettings.swift
//  CWWeChat
//
//  Created by chenwei on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit




/// layout 部分
class CWMessageLayoutSettings {
    
    public static var share = CWMessageLayoutSettings()
    
    var kMessageToLeftPadding: CGFloat
    
    var kMessageToTopPadding: CGFloat
    
    var kMessageToBottomPadding: CGFloat

    // 头像
    var kAvaterSize: CGSize
    // 昵称
    var kUsernameSize: CGSize
    
    var kUsernameLeftPadding: CGFloat

    var contentTextFont: UIFont
    
    var errorSize: CGSize
    
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

extension CWMessageLayoutSettings {
    
    
    
}
