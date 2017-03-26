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
    /// 用户名
    var userName: String = ""
    /// 头像URL
    var avatarURL: String = ""
    /// 昵称
    var nikeName: String = ""

    init(userId: String) {
        self.userId = userId
    }
    
    override var hashValue: Int {
        return self.userId.hash
    }
    
}
