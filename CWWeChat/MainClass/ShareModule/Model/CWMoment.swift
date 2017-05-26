//
//  CWMoment.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/29.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 图片
class CWMomentPictureModel: NSObject {
    var thumbnailURL: URL
    var largetURL: URL
    var size: CGSize = CGSize.zero
    
    init(thumbnailURL: URL, largetURL: URL, size: CGSize = .zero) {
        self.thumbnailURL = thumbnailURL
        self.largetURL = largetURL
    }
}

class CWMomentVideoModel: NSObject {
    var videoURL: URL
    init(videoURL: URL) {
        self.videoURL = videoURL
    }
}

enum CWMomentType: Int {
    case normal // 图文
    case vidio  // 视频
    case url
}

class CWMoment: NSObject {
    
    /// 分享id
    var shareId: String
    /// 用户名
    var username: String
    /// 用户id
    var userId: String
    
    var date: Date
    
    var shareType: CWMomentType = .normal

    var content: String?
    var videoModel: CWMomentVideoModel?
    
    var imageArray = [CWMomentPictureModel]()
    var commentArray = [CWMomentReply]()
    var praiseArray = [CWMomentReply]()
        
    // 是否上传成功
    var sendSuccess: Bool = true
    // 是否已经读过
    var isRead: Bool = false
    // 是否点赞
    var isPraise: Bool = false
    // 是否删除
    var isDelete: Bool = false

    init(shareId: String, username: String, userId: String, date: Date) {
        
        self.shareId = shareId
        self.username = username
        self.userId = userId
        self.date = date
    }
    
}
