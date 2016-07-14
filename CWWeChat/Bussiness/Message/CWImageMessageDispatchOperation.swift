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

    /// 上传图片的状态
    var imageUploadState:CWMessageUploadState = .None
    /// 上传图片的类
    let manager = CWResourceUploadManager()
    
    
    override func sendMessage() {
        /// 如果图片上传成功，则发送信息到对方，否则进行图片上传
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
        manager.uploadResource(chatMessage.content!) { (progress, result) in
            
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
        
        /// 图片大小通过消息拓展发送给对方，其实也可以在消息收到后，先对图片链接进行请求 获取到图片的大小信息和链接。
        let messageContent = chatMessage.messageContent as! CWImageMessageContent
        let expand = NSStringFromCGSize(messageContent.imageSize)
        let sendResult = messageTransmitter.sendMessage(content,
                                                        toId: toId!,
                                                        messageId: messageId,
                                                        type: 2,
                                                        expand: expand)
        messageSendCallback(sendResult)
    }
    
}
