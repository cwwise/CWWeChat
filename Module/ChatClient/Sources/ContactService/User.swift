//
//  User.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/3.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation

public class User {
    /// 聊天账号
    public var username: String
    /// 昵称
    public var nickname: String
    /// 头像
    public var avatarUrl: URL?
    /// 详细信息
    public var userInfo: UserInfo?
    
    public init(username: String,
                nickname: String,
                avatarUrl: URL? = nil) {
        self.username = username
        self.nickname = nickname
        self.avatarUrl = avatarUrl
    }    
}

public class UserInfo: CustomStringConvertible {
    // 真实名称
    public var realname: String?
    // 备注
    public var alias: String?
    // 签名
    public var sign: String?
    // email
    public var email: String?
    
    public var description: String {
        return "nickName:\(realname ?? "未设置"), sign:\(sign ?? "未设置")"
    }
}
