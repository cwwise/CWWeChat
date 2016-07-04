//
//  CWResourceUploadManager.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/3.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Qiniu

let token_key = "9tsvBuxK559rDYQdXGipXiLyWlru9hDyP2LzOB9S:cQKjc-Xd3ELg5n7_T4AL7qM7q6I=:eyJkZWFkbGluZSI6MTQ2ODA0NjAzOSwic2NvcGUiOiJjaGF0bWVzc2FnZS1pbWFnZSJ9"

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
