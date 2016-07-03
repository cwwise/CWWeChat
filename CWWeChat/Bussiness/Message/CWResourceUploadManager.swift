//
//  CWResourceUploadManager.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/3.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Qiniu

let token_key = "9tsvBuxK559rDYQdXGipXiLyWlru9hDyP2LzOB9S:EbR4FPoarTXBsAB_2nT8_5bi3qk=:eyJzY29wZSI6ImNoYXRtZXNzYWdlLWltYWdlIiwiZGVhZGxpbmUiOjE0Njc2MTIwNDR9"

class CWResourceUploadManager: NSObject {

    static let sharedInstance = CWResourceUploadManager()
    
    var manager:QNUploadManager
    private override init() {
        manager = QNUploadManager()
        super.init()
    }
    
    
    func uploadImage(imageName: String) {
        
        let progressHandler = { (string: String!, progess: Float!) in
//            print(string,progess)
        }
        
        let filePath = CWUserAccount.sharedUserAccount().pathUserChatImage(imageName)

        
        let token = QNUpToken.parse(token_key)
        print(token.bucket)
        
        let option = QNUploadOption(mime: nil, progressHandler: progressHandler, params: nil, checkCrc: false, cancellationSignal: nil)
        self.manager.putFile(filePath, key: imageName, token: token_key, complete: { (response, string, info) in
            print(response)
            print(string)
            }, option: option)

    }
    
}
