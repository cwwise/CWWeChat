//
//  CWChatKit.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYWebImage

public protocol CWChatUserInfoDataSource: NSObjectProtocol {
    func loadUserInfo(userId: String, completion: @escaping ( (CWChatUser?) -> Void))
}

public let kHeaderImageBaseURLString = "http://o7ve5wypa.bkt.clouddn.com/"

public class CWChatKit: NSObject {
    /// 单例
    public static let share = CWChatKit()
    
    public var cache: YYMemoryCache = {
        let cache = YYMemoryCache()
        cache.name = "cache"
        cache.shouldRemoveAllObjectsWhenEnteringBackground = false
        return cache
    }()
    
    public var chatWebImageManager: YYWebImageManager = {
        let path = "\(CWChatClient.share.userFilePath)/image"
        let imageCache = YYImageCache(path: path)
        imageCache?.diskCache.customFileNameBlock = { (key) in
            return key
        }
        let queue = OperationQueue()
        let chatWebImageManager = YYWebImageManager(cache: imageCache, queue: queue)
        chatWebImageManager.cacheKeyFilter = { (url) in
            return url.lastPathComponent
        }
        return chatWebImageManager
    }()
    
    
    public weak var userInfoDataSource: CWChatUserInfoDataSource?
    
    private override init() {
        super.init()
    }
}
