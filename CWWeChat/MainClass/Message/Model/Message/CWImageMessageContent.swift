//
//  CWImageMessageContent.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/5.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWImageMessageContent: CWMessageContent {
    
     /// 原始图
    var originalImage: UIImage?
     /// 缩略图
    var thumbnailImage: UIImage?
     /// 实际图片URL
    var imageUrl: String?
    var imagePath: String?
    
    var imageSize: CGSize = CGSizeZero
    
    init(image: UIImage) {
        self.originalImage = image
        super.init()
    }
    
    init(imagePath: String) {
        self.imagePath = imagePath
        super.init()
    }
    
    init(imageURI: String) {
        self.imageUrl = imageURI
        super.init()
    }
    
}
