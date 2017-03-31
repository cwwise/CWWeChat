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
    static let left_cap_insets = UIEdgeInsets(top: 30, left: 16, bottom: 16, right: 24)
    static let left_edge_insets = UIEdgeInsets(top: 18, left: 19, bottom: 18, right: 22)
    
    static let right_cap_insets = UIEdgeInsets(top: 30, left: 16, bottom: 16, right: 24)
    static let right_edge_insets = UIEdgeInsets(top: 18, left: 19, bottom: 18, right: 22)

}



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

