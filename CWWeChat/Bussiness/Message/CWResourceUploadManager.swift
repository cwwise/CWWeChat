//
//  CWResourceUploadManager.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/3.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Qiniu

let token_key = "9tsvBuxK559rDYQdXGipXiLyWlru9hDyP2LzOB9S:Yd6o3LD6-qNlV94Hiv4D0dpCoq0=:eyJzY29wZSI6ImNoYXRtZXNzYWdlLWltYWdlIiwiZGVhZGxpbmUiOjE0Njc4NTcyNjh9"

//使用七牛云存储(http://www.qiniu.com/)
//待做的是(本地生成token或者服务器生成token)，并根据不同类型的数据上传到不同的地址

/**
 资源上传的类
 */
class CWResourceUploadManager: NSObject {
    
    typealias UploadImageHandle = (Float, Bool) -> Void

    var manager:QNUploadManager
    
    override init() {
        manager = QNUploadManager()
        super.init()
    }
    
    
    func uploadResource(_ fileName: String, fileType: CWMessageType = .image, handle: @escaping UploadImageHandle) {
        
        //
        let progressHandler = { (string: String?, progess: Float!) in
            handle(progess,false)
        }
        
        let filePath = CWUserAccount.sharedUserAccount().pathUserChatImage(fileName)
        
        let option = QNUploadOption(mime: nil, progressHandler: progressHandler, params: nil, checkCrc: false, cancellationSignal: nil)
        self.manager.putFile(filePath, key: fileName, token: token_key, complete: { (response, string, info) in
           
            if response != nil {
                handle(1.0,true)
            } else {
                handle(0,false)
            }
            
            }, option: option)

    }
    
}
