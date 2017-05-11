//
//  ChatToolBarStyle.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public enum CWEmoticonType: Int {
    case image
    case emoji
    case favorite
    case expression //
}

///键盘相关的枚举
public enum CWMoreItemType: Int {
    case image
    case camera
    case video
    case videoCall
    case wallet
    case transfer
    case position
    case favorite
    case businessCard
    case voice
    case cards
}


let kMoreInputViewHeight: CGFloat = 216
let kChatToolBarHeight: CGFloat = 49

let kChatKeyboardHeight = kMoreInputViewHeight + kChatToolBarHeight


