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

class CWResourceUploadManager: NSObject {
    
    typealias UploadImageHandle = (Float, Bool) -> Void

    var manager:QNUploadManager
    
    override init() {
        manager = QNUploadManager()
        super.init()
    }
    
    
    func uploadImage(imageName: String, handle: UploadImageHandle) {
        
        //
        let progressHandler = { (string: String!, progess: Float!) in
            handle(progess,false)
        }
        
        let filePath = CWUserAccount.sharedUserAccount().pathUserChatImage(imageName)
        
        let option = QNUploadOption(mime: nil, progressHandler: progressHandler, params: nil, checkCrc: false, cancellationSignal: nil)
        self.manager.putFile(filePath, key: imageName, token: token_key, complete: { (response, string, info) in
           
            if response != nil {
                handle(1.0,true)
            } else {
                handle(0,false)
            }
            
            }, option: option)

    }
    
}
