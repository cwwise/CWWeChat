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
        if imageUploadState == 1 {
            sendContentMessage()
        } else {
            uploadImage()
        }
    }
    
    /// 上传图片
    func uploadImage() {
        
        // 生成随机的url
        let size1 = CGSize(width: 100, height: 200)
        let size2 = CGSize(width: 200, height: 200)
        let size3 = CGSize(width: 300, height: 400)
        let size4 = CGSize(width: 400, height: 800)
        let size5 = CGSize(width: 500, height: 600)
        let size6 = CGSize(width: 600, height: 300)
        let size7 = CGSize(width: 700, height: 400)

        let sizeIndex = Int(arc4random()%7)
        let size = [size1,size2,size3,size4,size5,size6,size7][sizeIndex]
        let index = String(format: "%03d", arguments: [arc4random()%10])
        
        let urlString = "http://image.cwcoder.com/cwwechat\(index).jpg?imageView2/1/w/\(Int(size.width))/h/\(Int(size.height))/q/100"
        let url = URL(string: urlString)
        let imageBody = message.messageBody as! CWImageMessageBody
        imageBody.size = size
        imageBody.originalURL = url
        
        
        var info = ["size": NSStringFromCGSize(size)]
        if let urlString = imageBody.originalURL?.absoluteString {
            info["url"] = urlString
        }
        
        let data = try! JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        let string = String(data: data, encoding: .utf8)!
        
        let toId = message.targetId
        let messageId = message.messageId
        let sendResult = self.messageTransmitter.sendMessage(content: string, targetId: toId, messageId: messageId ,type: message.messageType.rawValue)
        messageSendCallback(sendResult)
        
    }
    
    func sendContentMessage() {
        
        let toId = message.targetId
        let messageId = message.messageId
        
        let imageBody = message.messageBody as! CWImageMessageBody
        let content = String(describing: imageBody.originalURL)
        
        let sendResult = self.messageTransmitter.sendMessage(content: content, targetId: toId, messageId: messageId ,type: 1)
        messageSendCallback(sendResult)
    }
}
