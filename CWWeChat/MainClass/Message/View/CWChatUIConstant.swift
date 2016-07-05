//
//  CWChatUIConstant.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

//MARK: UI相关
internal struct ChatConversationCellUI {
    
    static let headerImageViewLeftPadding:CGFloat = 10.0
    static let headerImageViewTopPadding:CGFloat = 10.0
    
}


let defaultHeadeImage = CWAsset.Default_head.image

//消息在左边的时候， 文字距离屏幕左边的距离
let kChatTextLeftPadding: CGFloat = 72
//消息在左边的时候， 文字距离屏幕左边的距离
let kChatTextRightPadding: CGFloat = 82
//消息在右边， 70：文本离屏幕左的距离，  82：文本离屏幕右的距
let kChatTextMaxWidth: CGFloat = Screen_Width - kChatTextLeftPadding - kChatTextRightPadding

let kChatImageMaxWidth = Screen_Width * 0.45
let kChatImageMinWidth = Screen_Width * 0.25

