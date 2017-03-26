//
//  CWChatViewController+Keyboard.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

// MARK: - Keyboard
///响应KeyBoard事件
extension CWChatViewController {
    
    /**
     注册消息观察
     */
    func registerKeyboardNotifacation() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CWChatViewController.hideKeyboard))
        self.tableView.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(CWChatViewController.handleWillHideKeyboard(_:)),
                                                         name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(CWChatViewController.handleWillShowKeyboard(_:)),
                                                         name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(CWChatViewController.handleWillShowKeyboard(_:)),
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
        
        let keyboardFrameValue = (notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let curve = ((notification as NSNotification).userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue
        let duration = ((notification as NSNotification).userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let curveNumber = UIViewAnimationCurve(rawValue:curve)
        
        UIView.animate(withDuration: duration,
                                   delay: 0,
                                   options: self.animationOptionsForCurve(curveNumber!),
                                   animations: {
                                    
                                    if hideKeyBoard {
                                        self.chatToolBar.bottom = self.view.height
                                    } else {
                                        self.chatToolBar.bottom = self.view.height-keyboardFrame.height
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
