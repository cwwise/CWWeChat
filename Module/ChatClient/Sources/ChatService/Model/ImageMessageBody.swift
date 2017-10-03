//
//  ImageMessageBody.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public class ImageMessageBody: MessageBody {
   
    public func messageEncode() -> String {
        return ""
    }
    
    public func messageDecode(string: String) {
        
    }
    
    /// 消息体类型
    public var type: MessageType {
        return .image
    }    
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
        assert(path == nil && originalURL == nil, "本地路径和服务器路径不能同时为空")
        self.originalLocalPath = path
        self.originalURL = originalURL
        self.size = size
    }
    
    public var description: String {
        return "图片"
    }
    
}
