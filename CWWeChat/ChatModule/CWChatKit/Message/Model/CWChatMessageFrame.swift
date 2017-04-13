//
//  CWChatMessageFrame.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit
import YYText

/// 消息frame
public struct CWChatMessageFrame {
    
    /// 文字布局
    var textLayout: YYTextLayout?
    
    /// cell高度
    var heightOfCell: CGFloat
    
    /// 内容大小
    var contentSize: CGSize
    
    init(heightOfCell: CGFloat = 0,
         contentSize: CGSize = CGSize.zero,
         textLayout: YYTextLayout? = nil) {
        self.heightOfCell = heightOfCell
        self.contentSize = contentSize
        self.textLayout = textLayout
    }
    
    
    
    
    
    
}
