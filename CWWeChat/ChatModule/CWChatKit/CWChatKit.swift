//
//  CWChatKit.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

public protocol CWChatUserInfoDataSource: NSObjectProtocol {
    func loadUserInfo(userId: String, completion: @escaping ( (CWChatUser?) -> Void))
}

public let kImageBaseURLString = "http://qiniu.cwwise.com/"

public class CWChatKit: NSObject {
    /// 单例
    public static let share = CWChatKit()
    
    public var chatWebImageManager: ImageCache = {
        let cache = ImageCache(name: "hello")
        
        return cache
    }()
    
    // 保存图片 获取图片
    public func store(image: UIImage, forKey key: String) {
        
        let path = kChatUserImagePath+key
        if let data = DefaultCacheSerializer.default.data(with: image, original: nil) {
            FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
        }
    }
    
    
    public weak var userInfoDataSource: CWChatUserInfoDataSource?
    
    private override init() {
        super.init()
    }
}
