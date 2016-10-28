//
//  CWVoiceMessageDispatchOperation.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/12.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 类似发送图片类，可能有些不同，使用两个不同的类来处理
class CWVoiceMessageDispatchOperation: CWMessageDispatchOperation {

    var voiceUploadState:CWMessageUploadState = .none
    let manager = CWResourceUploadManager()
    
    override func sendMessage() {
        
        if voiceUploadState == .success {
            sendContentMessage()
        } else {
            uploadVoice()
        }
        
    }
    
    func uploadVoice() {
        
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
                self.voiceUploadState = .success
                self.sendContentMessage()
            }
            else if result == false && progress == 0.0 {
                CWLogDebug("上传失败..")
                self.voiceUploadState = .fail
            }
            else {
                self.voiceUploadState = .loading
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
        
//        let messageContent = chatMessage.messageContent as! CWVoiceMessageContent
//        let expand = NSStringFromCGSize(messageContent.imageSize)
        let sendResult = messageTransmitter.sendMessage(content,
                                                        toId: toId!,
                                                        messageId: messageId,
                                                        type: 3,
                                                        expand: nil)
        messageSendCallback(sendResult)
    }
    
    
}
