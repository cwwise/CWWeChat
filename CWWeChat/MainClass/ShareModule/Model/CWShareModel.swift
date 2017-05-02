//
//  CWShareModel.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/29.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 图片
class CWSharePictureModel: NSObject {
    var thumbnailURL: URL
    var largetURL: URL
    var size: CGSize = CGSize.zero
    
    init(thumbnailURL: URL, largetURL: URL, size: CGSize = .zero) {
        self.thumbnailURL = thumbnailURL
        self.largetURL = largetURL
    }
}

class CWShareVideoModel: NSObject {
    var videoURL: URL
    init(videoURL: URL) {
        self.videoURL = videoURL
    }
}

class CWShareModel: NSObject {
    
    /// 分享id
    var shareId: String
    /// 用户名
    var username: String
    /// 用户id
    var userId: String
    
    var date: Date

    var content: String?
    
    var videoModel: CWShareVideoModel?
    
    var imageArray = [CWSharePictureModel]()
    var commentArray = [CWShareReplyModel]()
    var praiseArray = [CWShareReplyModel]()

    init(shareId: String, username: String, userId: String, date: Date) {
        
        self.shareId = shareId
        self.username = username
        self.userId = userId
        self.date = date
    }
    
}
