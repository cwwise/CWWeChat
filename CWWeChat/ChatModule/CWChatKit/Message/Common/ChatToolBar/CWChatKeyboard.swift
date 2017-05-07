//
//  CWChatKeyboard.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWChatKeyboardStyle {
    case chat    //聊天
    case comment //评论
}

/// 数据源
protocol CWChatKeyboardDataSource {
    func chatKeyBoardMoreItems() -> [CWMoreItem]
}

public class CWChatKeyboard: UIView {
    
    public static let keyboard = CWChatKeyboard()
    
    public weak var associateTableView: UITableView?

    /// 风格
    var keyboardStyle: CWChatKeyboardStyle = .chat
    
    /// 是否开启语言
    var allowVoice: Bool = true
    /// 是否开启表情
    var allowFace: Bool = true
    /// 是否开启更多功能
    var allowMore: Bool = true
    
    var lastChatKeyboardY: CGFloat = 0.0
    
    private convenience init() {
        let frame = CGRect(x: 0, y: kScreenHeight-kChatKeyboardHeight,
                           width: kScreenWidth, height: kChatKeyboardHeight)
        self.init(frame: frame)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(chatToolBar)
        self.addSubview(moreInputView)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    var placeHolder: String? {
        didSet {
            
        }
    }
    
    var placeHolderColor: String? {
        didSet {
            
        }
    }
    
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
        switch self.chatToolBar.status {
        case .more: 
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { 
                
                self.moreInputView.isHidden = false
                
                self.lastChatKeyboardY = self.y
                
                self.frame = CGRect(x: 0, y: self.superview!.height, width: kScreenWidth, height: self.height)

                
                let frame = CGRect(x: 0, y: self.height-kMoreInputViewHeight, width: kScreenWidth, height: kMoreInputViewHeight)
                self.moreInputView.frame = frame
                
                self.updateAssociateTableViewFrame()
                
            }, completion: nil)
            
            break
            
        default: 
            let beginFrameValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            let beginFrame = beginFrameValue.cgRectValue
            
            let endFrameValue = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
            let endFrame = endFrameValue.cgRectValue
            
            let chatToolBarHeight = self.height - kMoreInputViewHeight
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
    
    // 开启键盘
    func keyboardUp() {
        if self.keyboardStyle == .comment {
            
        } else {
            
        }
    }
    
    // 隐藏键盘
    func keyboardDown() {
        if self.keyboardStyle == .comment {
            
        } else {
            
        }
    }
    
    // MARK: Getter
    lazy var chatToolBar: CWChatToolBar = {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kChatToolBarHeight)
        let chatToolBar = CWChatToolBar(frame:frame)
        return chatToolBar
    }()
    
    // 表情
    lazy var emoticonInputView: CWEmoticonInputView = {
        let emoticonInputView = CWEmoticonInputView.shareView
        return emoticonInputView
    }()
    
    // 更多部分
    lazy var moreInputView: CWMoreInputView = {
        let frame = CGRect(x: 0, y: kChatKeyboardHeight-kMoreInputViewHeight, width: kScreenWidth, height: kMoreInputViewHeight)
        let moreInputView = CWMoreInputView(frame: frame)
        return moreInputView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
