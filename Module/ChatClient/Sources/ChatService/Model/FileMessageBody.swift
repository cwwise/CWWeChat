
//
//  FileMessageBody.swift
//  ChatClient
//
//  Created by chenwei on 2018/3/21.
//

import Foundation

public class FileMessageBody {
    
    /// 显示名
    public var displayName: String = ""
    /// 附件大小 字节
    public var fileLength: Double = 0
    /// 服务器地址
    public var originalURL: URL?
    /// 本地路径
    public var originalLocalPath: String?
    
    init() {
        
    }
    
    public init(originalURL: URL?, displayName: String) {
        self.originalURL = originalURL
        self.displayName = displayName
    }
    
}

extension FileMessageBody: MessageBody {
    public var type: MessageType {
        return .file
    }
    
    var info: [String: String] {
        var info = ["length": "\(fileLength)", "name": displayName]
        if let urlString = self.originalURL?.absoluteString {
            info["url"] = urlString
        }
        
        if let path = self.originalLocalPath {
            info["path"] = path
        }
        return info
    }
    
    public func messageEncode() -> String {
        return info.jsonEncoded
    }
    
    public func messageDecode(string: String) {
        guard let data = string.data(using: .utf8) else { return }
        let json = JSON(data)
        
        self.displayName = json["name"].stringValue
        self.fileLength = json["length"].doubleValue
        self.originalLocalPath = json["path"].stringValue
        self.originalURL = json["url"].url
    }
    
    public var description: String {
        return "文件"
    }
    
}
