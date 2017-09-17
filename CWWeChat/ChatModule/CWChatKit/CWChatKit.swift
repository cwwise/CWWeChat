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
    func loadUserInfo(userId: String, completion: @escaping ( (CWUser?) -> Void))
}

public let kImageBaseURLString = "http://qiniu.cwwise.com/"

public class CWChatKit: NSObject {
    /// 单例
    public static let share = CWChatKit()
    
    public weak var userInfoDataSource: CWChatUserInfoDataSource?

    private var chatUserImagePath: String
    
    private override init() {
        chatUserImagePath = "\(CWChatClient.share.userFilePath)/image/"
        if FileManager.default.fileExists(atPath: chatUserImagePath) == false {
            try! FileManager.default.createDirectory(atPath: chatUserImagePath, withIntermediateDirectories: true, attributes: nil)
        }
        super.init()
    }
    
    public var chatWebImageManager: ImageCache = {
        let cache = ImageCache(name: "hello")
        
        return cache
    }()
    
    public func getFilePath(with fileName: String) -> String {
        return chatUserImagePath+fileName
    }
    
    // 保存图片 获取图片
    public func store(image: UIImage, forKey key: String) {
        let filePath = self.getFilePath(with: key)
        if let data = DefaultCacheSerializer.default.data(with: image, original: nil) {
            FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        }
    }

}
