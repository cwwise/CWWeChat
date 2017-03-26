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

//消息在左边的时候， 文字距离屏幕左边的距离
let kChatTextLeftPadding: CGFloat = 72
//消息在左边的时候， 文字距离屏幕左边的距离
let kChatTextRightPadding: CGFloat = 82
//消息在右边， 70：文本离屏幕左的距离，  82：文本离屏幕右的距
let kChatTextMaxWidth: CGFloat = kScreenWidth - kChatTextLeftPadding - kChatTextRightPadding

//图片
let kChatImageMaxWidth = kScreenWidth * 0.45
let kChatImageMinWidth = kScreenWidth * 0.25

let kChatVoiceMinWidth = kScreenWidth * 0.25
let kChatVoiceMaxWidth = kScreenWidth * 0.60

public enum CWEmojiType: Int {
    case emoji
    case favorite
    case face
    case image
}

public enum CWChatBarStatus: Int {
    case Init
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

