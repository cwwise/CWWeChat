//
//  CWUserAccount.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/27.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 当前登录的用户model
class CWUserAccount: NSObject {
   
    static let sharedUserAccount = CWUserAccount()
   
    var chatuser: CWContactUser
    
    var userID:String {
        get {
            return self.chatuser.userId
        }
    }
    
    ///
    init(chatuser: CWContactUser = CWContactUser()) {
        self.chatuser = chatuser
    }
}
