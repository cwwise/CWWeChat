//
//  CWImageMessageDispatchOperation.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 图片发送类
 
 图片发送，需要先上传文件到服务器，再发送消息到对方。
 */
class CWImageMessageDispatchOperation: CWMessageDispatchOperation {

    var imageUploadState:CWMessageUploadState = .None
    let manager = CWResourceUploadManager.sharedInstance
    
    override func sendMessage() {
        
        guard let chatMessage = self.chatMessage else {
            return
        }
        
        //上传照片
        manager.uploadImage(chatMessage.content!)
        
    }
    
    func sendContentMessage() {
        guard let chatMessage = self.chatMessage else {
            return
        }
        
        let toId = chatMessage.messageReceiveId
        let messageId = chatMessage.messageID
        let content = chatMessage.content
        
        let sendResult = messageTransmitter.sendMessage(content!, toId: toId!, messageId: messageId)
        messageSendCallback(sendResult)
    }
    
}
