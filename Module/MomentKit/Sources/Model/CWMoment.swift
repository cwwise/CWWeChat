//
//  CWMoment.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/29.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWMomentType: Int {
    case normal // 图文
    case vidio  // 视频
    case url
    case music  //音乐
}

/// 图片
class CWMomentPhoto: NSObject {
    var thumbnailURL: URL
    var largetURL: URL
    var size: CGSize = CGSize.zero
    
    init(thumbnailURL: URL, largetURL: URL, size: CGSize = .zero) {
        self.thumbnailURL = thumbnailURL
        self.largetURL = largetURL
        self.size = size
    }
}

class CWMomentVideo: NSObject {
    var videoURL: URL
    init(videoURL: URL) {
        self.videoURL = videoURL
    }
}

class CWMultimedia: NSObject {
    var url: URL
    var imageURL: URL
    var title: String
    var source: String?
    init(url: URL, imageURL: URL, title: String, source: String? = nil) {
        self.url = url
        self.imageURL = imageURL
        self.title = title
        self.source = source
    }
}



class CWMoment: NSObject {
    
    /// 分享id
    var momentId: String
    /// 用户名
    var username: String
    /// 用户id
    var userId: String
    
    var date: Date
    
    var type: CWMomentType = .normal

    var content: String?
    var videoModel: CWMomentVideo?
    var multimedia: CWMultimedia?
    var imageArray = [CWMomentPhoto]()
    
    
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

    init(momentId: String, username: String, userId: String, date: Date) {
        
        self.momentId = momentId
        self.username = username
        self.userId = userId
        self.date = date
    }
    
}
