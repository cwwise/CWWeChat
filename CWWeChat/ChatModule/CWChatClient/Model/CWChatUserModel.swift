//
//  CWChatUserModel.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public class CWUser: NSObject {
    
    var userId: String
    
    var nickname: String?

    private(set) var userInfo: CWUserInfo
    
    convenience init(userId: String, userInfo: CWUserInfo) {
        self.init(userId: userId)
        self.userInfo = userInfo
    }
    
    public init(userId: String) {
        userInfo = CWUserInfo()
        self.userId = userId
    }
}

public class CWUserInfo: NSObject {
    // 昵称
    var nickName: String?
    // 备注
    var alias: String?
    // 头像
    var avatarUrl: String?
    // 签名
    var sign: String?
    // email
    var email: String?
    
    public override var description: String {
        return "nickName:\(nickName ?? "未设置"), sign:\(sign ?? "未设置")"
    }
}

