//
//  CWConversationModel.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 会话类
 
 分为两种，个人聊天和群聊
 */
class CWConversationModel: NSObject {
   
    ///id
    ///TODO: 待修改
    var partnerID: String!
    ///时间
    var conversationDate: NSDate?
    ///会话类型
    var conversationType: CWChatType
    ///未读数量
    var unreadCount:Int = 0
    ///内容
    var content:String?
    ///是否读取
    var isRead: Bool {
        return self.unreadCount == 0
    }
    
    override init() {
        //默认是个人
        conversationType = .Personal
        super.init()
    }
    
    
}
