//
//  CWImageMessageDispatchOperation.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Alamofire

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
    
//        let url = "http://localhost:3000/upload"
//        
//        let parameters = [
//            "file_name": "swift_file.jpeg"
//        ]
//        
//        let imageBody = message.messageBody as! CWImageMessageBody
//        let fileURL = URL(fileURLWithPath: kChatUserImagePath+imageBody.originalLocalPath!)
//
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(fileURL, withName: "image")
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            }
//        }, to: url)
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                
//                upload.uploadProgress(closure: { (progress) in
//                    //Print progress
//                    print(progress)
//                })
//                
//                upload.responseJSON { response in
//                    print(response.result)
//                }
//                
//            case .failure(let encodingError): 
//                print(encodingError)
//                break
//            }
//        }
//        
        var progress: Int = 0
        while progress <= 100 {
            progress += 10
            self.progress?(progress)
            sleep(3)
        }
        
        if progress >= 100 {
            progress = 100
        }
        testInfo()
        sendContentMessage()
    }
    
    func testInfo() {
        
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
    }
    
    
    func sendContentMessage() {
        // 需要添加判断 判断originalURL是存在 存在则上传成功
        
        let imageBody = message.messageBody as! CWImageMessageBody

        var info = ["size": NSStringFromCGSize(imageBody.size)]
        if let urlString = imageBody.originalURL?.absoluteString {
            info["url"] = urlString
        }
        
        let data = try! JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        let string = String(data: data, encoding: .utf8)!
        
        let toId = message.targetId
        let messageId = message.messageId
    
        let sendResult = messageTransmitter.sendMessage(content: string,
                                                        targetId: toId,
                                                        messageId: messageId,
                                                        chatType: message.chatType.rawValue,
                                                        type: message.messageType.rawValue)
        messageSendCallback(sendResult)
    }
}
