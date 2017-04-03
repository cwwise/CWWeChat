//
//  CWContactModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWContactModel: NSObject {

    /// 用户id
    var userId: String
    /// 昵称
    var nickname: String?
    /// 用户名
    var username: String
    /// 头像URL
    var avatarURL: String?

    init(userId: String, username: String) {
        self.username = username
        self.userId = userId
    }
    
    override var hashValue: Int {
        return self.userId.hash
    }
    
}
