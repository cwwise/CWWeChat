//
//  CWMomentReply.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWMomentReplyType: Int {
    case unkown
    case comment
    case praise
}

class CWMomentReply: NSObject {
    // 对应的id
    var momentId: String!
    //
    var replyId: String!
    // 对应用户name和id
    var username: String!
    var userId: String!
    // 对应回复人的name和id
    var receiveUserId: String?
    var receiveUserName: String?
    /// 回复时间
    var replyDate: Date = Date()
    /// 类型
    var replyType: CWMomentReplyType = .unkown
    
    // 初始化方法
    init(replyId: String,
         momentId: String,
         username: String,
         userId: String) {
        
        self.replyId = replyId
        self.momentId = momentId
        self.username = username
        self.userId = userId
    }
}
