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
    func chatKeyBoardMoreItems() -> [CWMoreItem]
}

public class CWChatKeyBoard: UIView {
    
    public static let keyBoard = CWChatKeyBoard()

    public weak var associateTableView: UITableView?

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
    
    private convenience init() {
        let frame = CGRect(x: 0, y: kScreenHeight-kChatKeyBoardHeight, 
                           width: kScreenWidth, height: kChatKeyBoardHeight)
        self.init(frame: frame)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(chatToolBar)
        self.addSubview(moreKeyboard)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
        switch self.chatToolBar.status {
        case .more: 
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { 
                
                self.moreKeyboard.isHidden = false
                
                self.lastChatKeyboardY = self.y
                
                self.frame = CGRect(x: 0, y: self.superview!.height, width: kScreenWidth, height: self.height)

                
                let frame = CGRect(x: 0, y: self.height-kMoreKeyBoardHeight, width: kScreenWidth, height: kMoreKeyBoardHeight)
                self.moreKeyboard.frame = frame
                
                self.updateAssociateTableViewFrame()
                
            }, completion: nil)
            
            break
            
        default: 
            let beginFrameValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            let beginFrame = beginFrameValue.cgRectValue
            
            let endFrameValue = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
            let endFrame = endFrameValue.cgRectValue
            
            let chatToolBarHeight = self.height - kMoreKeyBoardHeight
            let targetY = endFrame.origin.y - chatToolBarHeight - (kScreenHeight - self.superview!.height)

            if beginFrame.height > 0 && (beginFrame.y - endFrame.y > 0) {
                
                self.lastChatKeyboardY = self.y

                
            }
            
            
        }
        
        
    }
    
    func updateAssociateTableViewFrame() {
        guard let tableView = associateTableView else {
            return
        }
        
        let original = tableView.contentOffset.y
        let keyboardOffset = self.y - self.lastChatKeyboardY
        tableView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.y)
        
        let tableViewContentDiffer = tableView.contentSize.height - tableView.height

        //是否键盘的偏移量，超过了表的整个tableViewContentDiffer尺寸
        var offset: CGFloat = 0
        if fabs(tableViewContentDiffer) > fabs(keyboardOffset) {
            offset = original-keyboardOffset
        }else {
            offset = tableViewContentDiffer
        }
        
        if tableView.contentSize.height + tableView.contentInset.top + tableView.contentInset.bottom > tableView.height {
            tableView.contentOffset = CGPoint(x: 0, y: offset)
        }
        
    }

    lazy var chatToolBar: CWInputToolBar = {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kChatToolBarHeight)
        let chatToolBar = CWInputToolBar(frame:frame)
        return chatToolBar
    }()
    
    lazy var moreKeyboard: CWMoreInputView = {
        let frame = CGRect(x: 0, y: kChatKeyBoardHeight-kMoreKeyBoardHeight, width: kScreenWidth, height: kMoreKeyBoardHeight)
        let moreKeyboard = CWMoreInputView(frame: frame)
        return moreKeyboard
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
