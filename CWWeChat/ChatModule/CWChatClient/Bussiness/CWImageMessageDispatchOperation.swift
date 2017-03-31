//
//  CWImageMessageDispatchOperation.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWImageMessageDispatchOperation: CWMessageDispatchOperation {
    
    var imageUploadState: Int = 0
    
    override func sendMessage() {
        /// 如果图片上传成功，则发送信息到对方，否则进行图片上传
        if imageUploadState == 0 {
            sendContentMessage()
        } else {
            uploadImage()
        }
    }
    
    /// 上传图片
    func uploadImage() {
        
    }
    
    func sendContentMessage() {
        
        let toId = message.targetId
        let messageId = message.messageId
        
        let imageBody = message.messageBody as! CWImageMessageBody
        let content = String(describing: imageBody.originalLocalPath)
        
        let sendResult = self.messageTransmitter.sendMessage(content: content, targetId: toId, messageId: messageId ,type: 1)
        messageSendCallback(sendResult)
        
        
    }
    
    
}
