//
//  CWChatUserModel.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/2.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

class CWChatUserModel: NSObject {

    //用户id
    var userId: String!
    //用户名
    var userName: String?
    //昵称
    var nikeName: String?
    //备注名
    var remarkName: String?
    //头像URL
    var avatarURL: String {
        let avatarURL = "http://o7ve5wypa.bkt.clouddn.com/"+self.userId
        return avatarURL
    }
    //头像路径
    var avatarPath: String?
    
    var isOnline: Bool = false
    
    init(info: Dictionary<String, AnyObject>) {
        
    }
    
    override init() {
        super.init()
    }
    
    override var hashValue: Int {
        return self.userId.hash
    }
    
}


func ==(lhs: CWChatUserModel, rhs: CWChatUserModel) -> Bool {
    return lhs.userId == rhs.userId
}



