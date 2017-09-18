//
//  CWChatUIConstant.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

// 上下留白
let kMessageCellTopMargin:      CGFloat =  2.0
let kMessageCellBottomMargin:   CGFloat =  12.0

let kChatTextMaxWidth = kScreenWidth * 0.58
//图片
let kChatImageMaxWidth = kScreenWidth * 0.45
let kChatImageMinWidth = kScreenWidth * 0.25

let kChatVoiceMaxWidth = kScreenWidth * 0.3

let defaultHeadeImage = CWAsset.Default_head.image

public struct ChatCellUI {
    
    static let bubbleTopMargin: CGFloat = 2
    static let bubbleBottomMargin: CGFloat = 11

    static let left_cap_insets   = UIEdgeInsets(top: 32, left: 40, bottom: 20, right: 40)
    /// 左边气泡背景区域 间距
    static let left_edge_insets  = UIEdgeInsets(top: 2+10, left: 17, bottom: 11+9.5, right: 17)
    
    static let right_cap_insets  = UIEdgeInsets(top: 32, left: 40, bottom: 20, right: 40)
    /// 右边气泡背景区域 间距
    static let right_edge_insets = UIEdgeInsets(top: 2+10, left: 17, bottom: 11+9.5, right: 17)
}

//MARK: UI相关
public struct ChatSessionCellUI {
    static let headerImageViewLeftPadding:CGFloat = 10.0
    static let headerImageViewTopPadding:CGFloat = 10.0
}

/*

let kTimeMessageCellHeight: CGFloat = 30.0

// cell布局中的间距
let kMessageCellMargin: CGFloat =  10.0

/// 头像
let kAvaterImageViewWidth:   CGFloat      = 40.0
let kAvaterImageViewMargin:  CGFloat      = 10.0

/// 名称
let kNameLabelHeight: CGFloat =   14.0
let kNameLabelSpaceX: CGFloat =   12.0
let kNamelabelSpaceY: CGFloat =   1.0


let kAvatarToMessageContent:    CGFloat = 5.0
let kMessageCellEdgeOffset:     CGFloat = 6.0

public let kChatTextAttribute = [NSAttributedStringKey.foregroundColor:UIColor.black,
                                 NSAttributedStringKey.font: UIFont.fontTextMessageText()]

*/



