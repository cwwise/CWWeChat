//
//  ChatKeyboardDelegate.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/7.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

protocol ChatKeyboardDelegate: NSObjectProtocol {
    
    func chatKeyboardWillShow()
    func chatKeyboardDidShow()
    func chatKeyboardWillDismiss()
    func chatKeyboardDidDismiss()
    
}

protocol CWMoreKeyboardDelegate:NSObjectProtocol {
    
    func moreKeyboard(_ keyboard: CWMoreKeyboard, didSelectedFunctionItem item:AnyObject)
    
}
