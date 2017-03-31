//
//  CWImageMessageBody.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWImageMessageBody: NSObject, CWMessageBody {
    
    weak var message: CWChatMessage?
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
    var originalLocalPath: String
    
    init(path: String) {
        self.originalLocalPath = path
    }
    
}
