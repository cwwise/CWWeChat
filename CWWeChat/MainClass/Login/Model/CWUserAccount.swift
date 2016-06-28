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
   
    class func sharedUserAccount() -> CWUserAccount {
        let applegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return applegate.userModel!
    }
   
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
