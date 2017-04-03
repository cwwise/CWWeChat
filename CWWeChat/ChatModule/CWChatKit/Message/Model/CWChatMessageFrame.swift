//
//  CWChatMessageFrame.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 消息frame
public struct CWChatMessageFrame {
    
    /// cell高度
    var heightOfCell: CGFloat
    
    /// 内容大小
    var contentSize: CGSize
    
    init(heightOfCell: CGFloat = 0, contentSize: CGSize = CGSize.zero) {
        self.heightOfCell = heightOfCell
        self.contentSize = contentSize
    }
    
    
    
    
    
}
