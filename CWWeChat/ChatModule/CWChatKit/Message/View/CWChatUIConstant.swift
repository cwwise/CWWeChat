//
//  CWChatUIConstant.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

//MARK: UI相关
public struct ChatSessionCellUI {
    static let headerImageViewLeftPadding:CGFloat = 10.0
    static let headerImageViewTopPadding:CGFloat = 10.0
}

let defaultHeadeImage = CWAsset.Default_head.image

//图片
let kChatImageMaxWidth = kScreenWidth * 0.45
let kChatImageMinWidth = kScreenWidth * 0.25

let kChatVoiceMinWidth = kScreenWidth * 0.25
let kChatVoiceMaxWidth = kScreenWidth * 0.60

public struct ChatCellUI {
    static let left_cap_insets = UIEdgeInsets(top: 13, left: 28, bottom: 13, right: 28)
    /// 左边气泡背景区域 间距
    static let left_edge_insets = UIEdgeInsets(top: 10, left: 17, bottom: 10, right: 17)
    
    static let right_cap_insets = UIEdgeInsets(top: 13, left: 28, bottom: 13, right: 28)
    /// 右边气泡背景区域 间距
    static let right_edge_insets = UIEdgeInsets(top: 10, left: 17, bottom: 10, right: 17)
}
