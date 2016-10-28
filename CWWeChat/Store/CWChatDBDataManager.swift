//
//  CWChatDBDataManager.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/7.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

/// 消息存储的类
class CWChatDBDataManager: NSObject {
    
    // TODO: 单例有些不好，想想怎么去解决。
    static let sharedInstance = CWChatDBDataManager()
    
    //用户id
    fileprivate(set) var userID:String
    //消息会话记录
    fileprivate(set) var dbRecordStore:CWChatDBRecordStore
    //消息记录
    fileprivate(set) var dbMessageStore:CWChatDBMessageStore

    fileprivate override init() {
        self.userID = CWUserAccount.sharedUserAccount().userID
        dbRecordStore = CWChatDBRecordStore(userId: self.userID)
        dbMessageStore = CWChatDBMessageStore(userId: self.userID)
        super.init()
    }
    
    
    
}

