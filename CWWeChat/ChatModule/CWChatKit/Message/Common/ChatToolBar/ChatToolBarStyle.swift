//
//  ChatToolBarStyle.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

public enum CWEmojiType: Int {
    case emoji
    case favorite
    case face
    case image
}

public enum CWToolBarStatus: Int {
    case initial
    case voice
    case more
    case emoji
    case keyboard
}


///键盘相关的枚举
public enum CWMoreKeyboardItemType: Int {
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
