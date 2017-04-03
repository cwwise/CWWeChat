//
//  CWChatUserModel.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public protocol CWChatUser: NSObjectProtocol {
    //用户Id
    var userId: String {get}
    // 用户名称
    var nickname: String? {get set}
    // 用户头像
    var avatarURL: String? {get set}
    
}

class CWChatUserModel: NSObject, CWChatUser {
    
    private(set) var userId: String
    var nickname: String?
    var avatarURL: String?

    init(userId: String) {
        self.userId = userId
    }
}
