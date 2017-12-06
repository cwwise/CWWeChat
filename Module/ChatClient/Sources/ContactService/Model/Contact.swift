//
//  User.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/3.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation

/// 联系人
public class Contact {
    // 聊天账号 (chenwei)  @cwwise.com
    public var username: String
    // 用户唯一id
    public var userId: String!
    // 昵称
    public var nickname: String
    // 头像
    public var avatarUrl: URL?
    /// 详细信息
    public var info: ContactInfo?
    
    public init(username: String,
                nickname: String = "", 
                avatarUrl: URL? = nil) {
        self.username = username
        self.nickname = nickname
        self.avatarUrl = avatarUrl
    }    
}

extension Contact: Hashable {
    public var hashValue: Int {
        return username.hashValue
    }
    
    public static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.username == rhs.username
    }
}

public class ContactInfo: CustomStringConvertible {
    // 真实名称
    public var realname: String?
    // 签名
    public var sign: String?
    // email
    public var email: String?
    // 备注
    public var remarkname: String?

    public var description: String {
        return "nickName:\(realname ?? "未设置"), sign:\(sign ?? "未设置")"
    }
}
