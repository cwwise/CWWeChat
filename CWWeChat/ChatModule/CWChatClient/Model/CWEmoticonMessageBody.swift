//
//  CWEmoticonMessageBody.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import SwiftyJSON

class CWEmoticonMessageBody: NSObject, CWMessageBody {
    weak var message: CWMessage?
    /// 消息体类型
    var type: CWMessageType = .emoticon
    /// 本地路径
    var originalLocalPath: String?
    /// 服务器地址
    var originalURL: URL?
    
    var size: CGSize = CGSize.zero

    init(localPath: String? = nil,
         remoteURL: URL? = nil) {
        
        self.originalLocalPath = localPath
        self.originalURL = remoteURL
    }
}

extension CWEmoticonMessageBody {
    
    var info: [String: String] {
        
        var info = ["size": NSStringFromCGSize(size)]
        if let urlString = self.originalURL?.absoluteString {
            info["url"] = urlString
        }
        
        if let path = self.originalLocalPath {
            info["path"] = path
        }
        return info
    }
    
    var messageEncode: String {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self.info, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    func messageDecode(string: String) {
        
        let json: JSON = JSON(parseJSON: string)
        if let size = json["size"].string {
            self.size = CGSizeFromString(size)
        }
        if let path = json["path"].string {
            self.originalLocalPath = path
        }
        
        if let urlstring = json["url"].string,
            let url = URL(string: urlstring) {
            self.originalURL = url
        }
        
    }
    
}
