//
//  CWCellLayout.swift
//  CWWeChat
//
//  Created by chenwei on 2017/6/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol CWCellLayoutConfig {
    // 头像到左边的距离
    func avatarLeftMargin() -> CGFloat
    // 头像到上边的距离
    func avatarTopMargin() -> CGFloat
    // 头像布局
    func avatarRect(message: CWChatMessageModel) -> CGRect
    // 用户名
    func usernameRect(message: CWChatMessageModel) -> CGRect
    // 内容部分
    func contentViewRect(message: CWChatMessageModel) -> CGRect
    
    func errorRect(message: CWChatMessageModel) -> CGRect
    
    func activityCenter(message: CWChatMessageModel) -> CGPoint
}

extension CWCellLayoutConfig {
    
    func avatarLeftMargin() -> CGFloat {
        return kAvaterImageViewMargin
    }
    // 头像到上边的距离
    func avatarTopMargin() -> CGFloat {
        return kMessageCellTopMargin
    }
    
    func avatarRect(message: CWChatMessageModel) -> CGRect {
        var avatar_x: CGFloat
        if message.isSend {
            avatar_x = kScreenWidth-kAvaterImageViewWidth-avatarLeftMargin()
        } else {
            avatar_x = avatarLeftMargin()
        }
        return CGRect(x: avatar_x, y: avatarTopMargin(), 
                      width: kAvaterImageViewWidth, height: kAvaterImageViewWidth)
    }
    
    func usernameRect(message: CWChatMessageModel) -> CGRect {
        
        var username_x: CGFloat
        var username_h: CGFloat
        
        if message.isSend {
            username_x = kScreenWidth - kMessageCellEdgeOffset - avatarRect(message: message).left
        } else {
            username_x = avatarRect(message: message).right + kMessageCellEdgeOffset
        }
        if message.showUserName {
            username_h = 20
        } else {
            username_h = 0
        }
        return CGRect(x: username_x, y: avatarTopMargin(), 
                      width: 120, height: username_h)
    }

    
    func contentViewRect(message: CWChatMessageModel) -> CGRect {
        
        let content_y = usernameRect(message: message).bottom
        var origin: CGPoint
        if message.isSend {
            origin = CGPoint(x: avatarRect(message: message).left-kAvatarToMessageContent-message.messageFrame.contentSize.width,
                             y: content_y)
        } else {
            origin = CGPoint(x: avatarRect(message: message).right+kAvatarToMessageContent, 
                             y: content_y)
        }
        
        return CGRect(origin: origin, size: message.messageFrame.contentSize)
        
    }
    
    func errorRect(message: CWChatMessageModel) -> CGRect {
        var error_x: CGFloat
        if message.isSend {
            error_x = contentViewRect(message: message).left - 2 - 15
        } else {
            error_x = contentViewRect(message: message).right + 2 + 15
        }
        return CGRect(x: error_x, y: contentViewRect(message: message).midY-5, width: 15, height: 15)
    }
    
    func activityCenter(message: CWChatMessageModel) -> CGPoint {
        var activity_x: CGFloat
        if message.isSend {
            activity_x = contentViewRect(message: message).left - 2 - 15
        } else {
            activity_x = contentViewRect(message: message).right + 2 + 15
        }
        return CGPoint(x: activity_x, y: contentViewRect(message: message).midY-5)
    }
    
}


class CWMessageCellLayout: CWCellLayoutConfig {
    

    var contentLayout: CWContentCellLayoutConfig?
}
