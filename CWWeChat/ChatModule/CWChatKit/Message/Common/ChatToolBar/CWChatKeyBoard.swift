//
//  CWChatKeyBoard.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWChatKeyBoardStyle {
    case chat
    case comment
}

/// 数据源
protocol CWChatKeyBoardDataSource {
    func chatKeyBoardMoreItems() -> [CWMoreKeyboardItem]
}

public class CWChatKeyBoard: UIView {
    
    public static let keyBoard = CWChatKeyBoard()

    public var associateTableView: UITableView?
    
    public var chatToolBar: CWInputToolBar?
    public var moreKeyboard: CWMoreKeyBoard?
    
    /// 风格
    var keyBoardStyle: CWChatKeyBoardStyle = .chat
    
    var placeHolder: String?
    
    /// 是否开启语言
    var allowVoice: Bool = true
    /// 是否开启表情
    var allowFace: Bool = true
    /// 是否开启更多功能
    var allowMore: Bool = true
    
    var lastChatKeyboardY: CGFloat = 0.0

    
    func keyboardUp() {
        
    }
    
    func keyboardDown() {
        
    }
    
}
