//
//  CWChatService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

class CWChatService: NSObject {
    
    
}


// MARK: - CWChatManager
extension CWChatService: CWChatManager {
    
    func addDelegate(_ delegate: CWChatManagerDelegate) {
        
    }
    
    func addDelegate(_ delegate: CWChatManagerDelegate, delegateQueue: DispatchQueue) {
        
    }
    
    func removeDelegate(_ delegate: CWChatManagerDelegate) {
        
    }
    
    /// 发送回执消息
    func sendMessageReadAck(message: CWChatMessage, completion: (CWChatMessage, Error?) -> Void) {
        
    }
    
    /// 发送消息
    ///
    /// - Parameters:
    ///   - message: 消息实体
    ///   - progress: 进度 当消息是资源类型时
    ///   - completion: 发送消息结果
    func sendMessage(message: CWChatMessage, progress: ((Int) -> Void), completion: (CWChatMessage, Error?) -> Void) {
        
        // 发送消息 先保存到数据库
        
        // 先插入到消息列表
        
        CWChatXMPPManager.share.dispatchManager.sendMessage(message)
        
    }
 
    
}
