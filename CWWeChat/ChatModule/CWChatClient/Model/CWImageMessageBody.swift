//
//  CWImageMessageBody.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import SwiftyJSON

class CWImageMessageBody: NSObject, CWMessageBody {
    
    weak var message: CWMessage?
    /// 消息体类型
    var type: CWMessageType = .image
    /// 图片尺寸
    var size = CGSize.zero
    /// 缩略图尺寸
    var thumbnailSize = CGSize.zero
    
    /// 设置发送图片消息时的压缩率
    var compressionRatio: Double = 0.6
    
    /// 缩略图的本地路径
    var thumbnailLocalPath: String?
    /// 缩略图服务器地址
    var thumbnailURL: URL?
    
    /// 原图服务器地址
    var originalURL: URL?
    /// 原图的本地路径
    var originalLocalPath: String?
    
    init(path: String? = nil,
         originalURL:URL? = nil,
         size: CGSize = CGSize.zero) {
        self.originalURL = originalURL
        self.originalLocalPath = path
        self.size = size
    }
    
}

extension CWImageMessageBody {
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
}

extension CWImageMessageBody {
    
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
