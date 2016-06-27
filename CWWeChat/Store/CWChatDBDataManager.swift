//
//  CWChatDBDataManager.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/7.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

class CWChatDBDataManager: NSObject {
    
    // TODO: 单例有些不好，想想怎么去解决。
    static let sharedInstance = CWChatDBDataManager()
    //用户id
    private(set) var userID:String
    //消息会话记录
    private(set) var dbRecordStore:CWChatDBRecordStore
    //消息记录
    private(set) var dbMessageStore:CWChatDBMessageStore

    private override init() {
        self.userID = CWUserAccount.sharedUserAccount.userID
        dbRecordStore = CWChatDBRecordStore(userId: self.userID)
        dbMessageStore = CWChatDBMessageStore()
    }
    
    
    
}

