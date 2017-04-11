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
    var largetURL: URL!
    var thumbnailURL: URL!
    var size: CGSize = .zero
}

class CWShareVideoModel: NSObject {
    var videoURL: URL!
}

class CWShareModel: NSObject {
    
    /// 分享id
    var shareId: String!
    /// 用户名
    var username: String!
    /// 用户id
    var userId: String!
    
    var content: String!
    
    var createdAt: Date!

    var videoModel: CWShareVideoModel!
    
    var imageArray = [CWSharePictureModel]()
    var commentArray = [CWShareReplyModel]()
    var praiseArray = [CWShareReplyModel]()

}
