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

    private(set) var userInfo: CWUserInfo?
    
    init(userId: String) {
        
        self.userId = userId
    }
}

public class CWUserInfo: NSObject {
    // 昵称
    var nickName: String?
    // 备注
    var alias: String?
    
    var avatarUrl: String?
    
    var sign: String?
    
    var gender: String?
    
    var email: String?
}

