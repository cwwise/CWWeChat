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
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(CWChatViewController.handleWillHideKeyboard(_:)),
                                                         name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(CWChatViewController.handleWillShowKeyboard(_:)),
                                                         name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(CWChatViewController.handleWillShowKeyboard(_:)),
                                                         name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
    ///键盘将要隐藏
    func handleWillHideKeyboard(notification: NSNotification)  {
        keyboardWillShowHide(notification, hideKeyBoard:true)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        
    }
    
    func handleWillShowKeyboard(notification: NSNotification)  {
        keyboardWillShowHide(notification)
    }
    
    func keyboardWillShowHide(notification:NSNotification, hideKeyBoard: Bool = false) {
        
        let keyboardFrameValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = keyboardFrameValue.CGRectValue()
        let curve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue
        let duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let curveNumber = UIViewAnimationCurve(rawValue:curve)
        
        UIView.animateWithDuration(duration,
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
    
    
    func animationOptionsForCurve(curve:UIViewAnimationCurve) -> UIViewAnimationOptions {
        
        switch curve {
        case .EaseInOut:
            return UIViewAnimationOptions.CurveEaseInOut
        case .EaseIn:
            return UIViewAnimationOptions.CurveEaseIn
        case .EaseOut:
            return UIViewAnimationOptions.CurveEaseOut
        case .Linear:
            return UIViewAnimationOptions.CurveLinear
        }
        
    }

}