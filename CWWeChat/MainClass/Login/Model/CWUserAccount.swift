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
    
    //登录xmpp需要的密码
    var password: String = "123456"
    var resource: String = "weiweideMacBook-Simulator"
    
    var userID:String {
        get {
            return self.chatuser.userId
        }
    }
    
    //
    init(chatuser: CWContactUser) {
        self.chatuser = chatuser
        super.init()
    }
    
    // TODO: 将这个单独用类来管理
    func pathUserChatImage(imageName: String) -> String {
        let documentPath = NSHomeDirectory().stringByAppendingString("/Documents")
        let userId = self.userID
        let path = "\(documentPath)/User/\(userId)/Chat/Images/"
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        return path.stringByAppendingString(imageName)
    }
    
    func pathUserChatVoice(imageName: String) -> String {
        let documentPath = NSHomeDirectory().stringByAppendingString("/Documents")
        let userId = self.userID
        let path = "\(documentPath)/User/\(userId)/Chat/Voices/"
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        return path.stringByAppendingString(imageName)
    }
    
}
