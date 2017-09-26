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
    // 昵称
    var nickname: String?
    // 头像
    var avatarUrl: URL?
    
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
    // 签名
    var sign: String?
    // email
    var email: String?
    
    public override var description: String {
        return "nickName:\(nickName ?? "未设置"), sign:\(sign ?? "未设置")"
    }
}

