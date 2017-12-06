//
//  EmoticonMessageBody.swift
//  Alamofire
//
//  Created by chenwei on 2017/10/4.
//

import UIKit

public class EmoticonMessageBody {
    /// 本地路径
    public var originalLocalPath: String?
    /// 服务器地址
    public var originalURL: URL?
    
    public var size: CGSize = CGSize.zero
    
    init() {}
    
    public init(localPath: String? = nil,
                remoteURL: URL? = nil) {
        
        self.originalLocalPath = localPath
        self.originalURL = remoteURL
    }
}

extension EmoticonMessageBody: MessageBody {
    
    public var type: MessageType { 
        return .emoticon
    }
    
    public func messageEncode() -> String {
        return "text"
    }
    
    public func messageDecode(string: String) {
        
    }
    
    public var description: String {
        return ""
    }
    
}
