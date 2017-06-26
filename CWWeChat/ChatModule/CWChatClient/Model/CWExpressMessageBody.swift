//
//  CWExpressMessageBody.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWExpressMessageBody: NSObject, CWMessageBody {
    weak var message: CWMessage?
    /// 消息体类型
    var type: CWMessageType = .expression
    /// 本地路径
    var localPath: String?
    /// 服务器地址
    var remoteURL: URL?
    
    init(localPath: String? = nil,
         remoteURL: URL? = nil) {
        
        self.localPath = localPath
        self.remoteURL = remoteURL
        
    }
    
}

extension CWExpressMessageBody {
    
    var messageEncode: String {
        return ""
    }
    
    func messageDecode(string: String) {
        
    }
    
}
