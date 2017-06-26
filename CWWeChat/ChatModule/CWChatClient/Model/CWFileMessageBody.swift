//
//  CWFileMessageBody.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWFileMessageBody: NSObject, CWMessageBody {
    
    weak var message: CWMessage?
    /// 消息体类型
    var type: CWMessageType = .file
    
    var displayName: String = "未知"
    /// 本地路径
    var localPath: String?
    /// 服务器地址
    var remoteURL: URL?
    
    /// 以字节为单位
    var fileLength: Int = 0
    
    init(localPath: String? = nil, 
         remoteURL: URL? = nil, 
         displayName: String) {
        
        self.localPath = localPath
        self.remoteURL = remoteURL
        self.displayName = displayName
        
    }
}

extension CWFileMessageBody {
    
    var messageEncode: String {
        return ""
    }
    
    func messageDecode(string: String) {
        
    }
    
}
