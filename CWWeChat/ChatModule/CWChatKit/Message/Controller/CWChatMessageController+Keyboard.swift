//
//  CWChatMessageController+Keyboard.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

// MARK: - Keyboard
///响应KeyBoard事件
extension CWChatMessageController {
    
    /**
     注册消息观察
     */
    func registerKeyboardNotifacation() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWillHideKeyboard(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWillShowKeyboard(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWillShowKeyboard(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
    ///键盘将要隐藏
    func handleWillHideKeyboard(_ notification: Notification)  {
        keyboardWillShowHide(notification, hideKeyBoard:true)
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
    }
    
    func handleWillShowKeyboard(_ notification: Notification)  {
        keyboardWillShowHide(notification)
    }
    
    func keyboardWillShowHide(_ notification:Notification, hideKeyBoard: Bool = false) {
        
        let keyboardFrameValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let curve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue
        let duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let curveNumber = UIViewAnimationCurve(rawValue:curve)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: self.animationOptionsForCurve(curveNumber!),
                       animations: {
                        
                        if hideKeyBoard {
                            self.chatToolBar.bottom = self.view.height
                            self.tableView.bottom = self.chatToolBar.top
                        } else {
                            self.chatToolBar.bottom = self.view.height-keyboardFrame.height
                            self.tableView.bottom = self.chatToolBar.top
                        }
                        
                        
        }) { (bool) in
            
            
        }
        
    }
    
    
    func animationOptionsForCurve(_ curve:UIViewAnimationCurve) -> UIViewAnimationOptions {
        
        switch curve {
        case .easeInOut:
            return UIViewAnimationOptions()
        case .easeIn:
            return UIViewAnimationOptions.curveEaseIn
        case .easeOut:
            return UIViewAnimationOptions.curveEaseOut
        case .linear:
            return UIViewAnimationOptions.curveLinear
        }
        
    }
    
}
