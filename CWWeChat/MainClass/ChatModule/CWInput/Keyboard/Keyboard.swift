//
//  Keyboard.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

/// 点击事件
protocol KeyboardDelegate {
    
    
    
}

enum KeyboardType {
    case normal
    case comment
}

private let kInputViewHeight: CGFloat = 216
private let kToolViewHeight: CGFloat = 49

class Keyboard: UIView {
    
    var type: KeyboardType = .normal

    var status: ToolViewStatus = .none
    
    var keyBoardFrameTop: CGFloat = 0
    // 屏蔽模态视图中 收到其他界面的键盘通知
    var close: Bool = false
    
    //MARK: 属性
    lazy var toolView: ToolView = {
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: kToolViewHeight)
        let toolView = ToolView(frame: frame)
        toolView.delegate = self
        return toolView
    }()
    
    lazy var emoticonInputView: EmoticonInputView = {
        let frame = CGRect(x: 0, y: kToolViewHeight, width: self.bounds.width, height: kInputViewHeight)
        let inputView = EmoticonInputView(frame: frame)
        inputView.delegate = self
        return inputView
    }()
    
    lazy var moreInputView: MoreInputView = {
        let frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: kInputViewHeight)
        let inputView = MoreInputView(frame: frame)
        inputView.delegate = self
        return inputView
    }()
    
    /// @用户的数组
    var atCache: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func endInputing() {
        refreshStatus(.none)
        if self.toolView.showsKeyboard {
            self.toolView.showsKeyboard = false
        } else {
            UIView.animate(withDuration: 0.25) {
                self.top = self.superview!.height - kToolViewHeight
            }
        }
    }
    
    override func didMoveToWindow() {
        setup()
    }
    
    func setup() {
        
        self.addSubview(toolView)
        self.addSubview(emoticonInputView)
        self.addSubview(moreInputView)

        toolView.emoticonButton.addTarget(self, action: #selector(handelEmotionClick(_:)), for: .touchUpInside)
        toolView.voiceButton.addTarget(self, action: #selector(handelVoiceClick(_:)), for: .touchUpInside)
        toolView.moreButton.addTarget(self, action: #selector(handelMoreClick(_:)), for: .touchUpInside)        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowFrame(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
     
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideFrame(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        refreshStatus(.text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
        if !(self.window != nil) {
            return
        }
        
        let userInfo = notification.userInfo!
        let endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
       // let beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue

        self.keyBoardFrameTop = endFrameValue.cgRectValue.minY
    }
    
    @objc func keyboardWillShowFrame(_ notification: Notification) {
        
        let userInfo = notification.userInfo!
        let endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
       // let beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        
        UIView.animate(withDuration: 0.25) {
            self.top = endFrameValue.cgRectValue.minY - kToolViewHeight
        }
    }
    
    @objc func keyboardWillHideFrame(_ notification: Notification) {
        // 收到键盘消失
        let userInfo = notification.userInfo!
        let endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        // 判断情况 如果键盘模式和语音 则下落
        if self.status == .text || self.status == .audio {
            
            UIView.animate(withDuration: 0.25) {
                self.top = endFrameValue.cgRectValue.minY - kToolViewHeight
            }
            
        }
        // 如果是表情和更多则保持高度
        else {
            
            
            
        }
        
        
        
    }
    
    
    func refreshStatus(_ status: ToolViewStatus) {
  
        
        self.status = status
    }
    
    // MARK: Action
    @objc func handelVoiceClick(_ sender: UIButton) {
        
    }
    
    @objc func handelEmotionClick(_ sender: UIButton) {
        
        if self.status != .emoticon {
            
            self.bringSubview(toFront: emoticonInputView)
            moreInputView.alpha = 0
            emoticonInputView.alpha = 1
            UIView.animate(withDuration: 0.25, animations: {
                self.emoticonInputView.top = kToolViewHeight
            })
            
            if self.toolView.showsKeyboard {
                self.status = .emoticon
                self.toolView.showsKeyboard = false
            } else {
                self.refreshStatus(.emoticon)
            }
            
        } else {
            self.status = .text
            self.toolView.showsKeyboard = true
        }
        
    }
    
    @objc func handelMoreClick(_ sender: UIButton) {
        
        if self.status != .more {
            
            self.bringSubview(toFront: moreInputView)
            moreInputView.alpha = 1
            emoticonInputView.alpha = 0

            UIView.animate(withDuration: 0.25, animations: {
                self.moreInputView.top = kToolViewHeight
            })
            
            if self.toolView.showsKeyboard {
                self.status = .more
                self.toolView.showsKeyboard = false
            } else {
                self.refreshStatus(.more)
            }
            
        } else {
            self.status = .more
            self.toolView.showsKeyboard = true
        }
    }
    
}

// MARK: text部分
extension Keyboard {
    
    func onTextDelete() {
        
    }
    
    
    
}


extension Keyboard: ToolViewDelegate {
    
    func textViewShouldBeginEditing() {
        self.status = .text
        UIView.animate(withDuration: 0.25, animations: {
            self.emoticonInputView.alpha = 0
            self.moreInputView.alpha = 0

        }) { (finshed) in
            self.moreInputView.top = kInputViewHeight
            self.emoticonInputView.top = kInputViewHeight
        }

    }
}


// MARK: - EmoticonInputViewDelegate
extension Keyboard: EmoticonInputViewDelegate {
    
    func emoticonInputView(_ inputView: EmoticonInputView, didSelect emoticon: Emoticon) {
        
    }
    
    
    func didPressSend(_ inputView: EmoticonInputView) {
     
        
    }
    
    func didPressDelete(_ inputView: EmoticonInputView) {
        
    }
    
}

// MARK: - MoreInputViewDelegate
extension Keyboard: MoreInputViewDelegate {
    
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem) {
        
        
    }
    
}
