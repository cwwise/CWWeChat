//
//  MessageFrame.swift
//  ChatKit
//
//  Created by wei chen on 2017/10/23.
//

import Foundation

class MessageFrame {
    
    var avaterFrame: CGRect
    
    var usernameFrame: CGRect
    // 内容部分
    var messageContainerFrame: CGRect
    
    var messageContainerInsets: UIEdgeInsets
    
    var errorFrame: CGRect
    
    var activityFrame: CGRect
    
    var sizeOfItem: CGSize = CGSize.zero
    
    init() {
        avaterFrame = CGRect.zero
        usernameFrame = CGRect.zero
        messageContainerFrame = CGRect.zero
        messageContainerInsets = UIEdgeInsets.zero
        errorFrame = CGRect.zero
        activityFrame = CGRect.zero
    }
    
}
