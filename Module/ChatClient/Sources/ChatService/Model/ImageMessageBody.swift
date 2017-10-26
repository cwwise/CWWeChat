//
//  ImageMessageBody.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public class ImageMessageBody {
    /// 图片尺寸
    public var size = CGSize.zero
    
    /// 缩略图的本地路径
    public var thumbnailLocalPath: String?
    /// 缩略图服务器地址
    public var thumbnailURL: URL?
    
    /// 原图服务器地址
    public var originalURL: URL?
    /// 原图的本地路径
    public var originalLocalPath: String?
    
    public init(path: String? = nil,
         originalURL:URL? = nil,
         size: CGSize = CGSize.zero) {
        assert(path == nil || originalURL == nil, "本地路径和服务器路径不能同时为空")
        self.originalLocalPath = path
        self.originalURL = originalURL
        self.size = size
    }
}

extension ImageMessageBody: MessageBody {
    /// 消息体类型
    public var type: MessageType {
        return .image
    }
    
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
    
    public func messageEncode() -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.info, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    public func messageDecode(string: String) {
        guard let data = string.data(using: .utf8) else { return }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String]
            if let size = json?["size"] {
                self.size = CGSizeFromString(size)
            }
            if let path = json?["path"] {
                self.originalLocalPath = path
            }
            if let urlstring = json?["url"],
                let url = URL(string: urlstring) {
                self.originalURL = url
            }
        } catch {
            
        }
    }
    
    public var description: String {
        return "图片"
    }
}


