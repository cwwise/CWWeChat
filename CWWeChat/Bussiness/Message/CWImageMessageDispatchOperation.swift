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
    let manager = CWResourceUploadManager()
    
    override func sendMessage() {
        
        if imageUploadState == .Success {
            sendContentMessage()
        } else {
            uploadImage()
        }
        
    }
    
    func uploadImage() {
        
        guard let chatMessage = self.chatMessage else {
            return
        }
        //上传照片
        manager.uploadImage(chatMessage.content!) { (progress, result) in
            
            if let progressBlock = self.progressBlock {
                progressBlock(progress, result)
            }
            
            if result == true && progress == 1.0 {
                CWLogDebug("上传成功..")
                self.imageUploadState = .Success
                self.sendContentMessage()
            }
            else if result == false && progress == 0.0 {
                CWLogDebug("上传失败..")
                self.imageUploadState = .Fail
            }
            else {
                self.imageUploadState = .Loading
            }
        }
    }
    
    func sendContentMessage() {
        guard let chatMessage = self.chatMessage else {
            return
        }
        
        let toId = chatMessage.messageTargetId
        let messageId = chatMessage.messageID
        let content = chatMessage.content!
        
        let sendResult = messageTransmitter.sendMessage(content, toId: toId!, messageId: messageId, type: 2)
        messageSendCallback(sendResult)
    }
    
}
