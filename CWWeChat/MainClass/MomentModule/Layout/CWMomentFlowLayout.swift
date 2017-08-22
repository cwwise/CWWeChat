//
//  CWMomentFlowLayout.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

class CWMomentFlowLayout: UICollectionViewFlowLayout {
    
    override class var layoutAttributesClass: Swift.AnyClass {
        return CWMomentAttributes.self
    }
    
    ///
    var cellHeight: CGFloat = 0
    
    /// 头像
    var avatarFrame: CGRect = .zero
    /// 用户名
    var usernameFrame: CGRect = .zero
    
    /// 图片或者新闻(音乐)
    var multimediaFrame: CGRect = .zero
    /// 图片大小(待修改 如果图片只有一张需要根据比例算)
    var pictureSize: CGSize = .zero
    
    /// 
    var toolButtonFrame: CGRect = .zero
    
    /// 点赞部分
    var praiseHeight: CGFloat = 0
    var praiseLayout: YYTextLayout?
    
    var commentHeight: CGFloat = 0
    var commentLayoutArray = [YYTextLayout]()
}


extension CWMomentFlowLayout {
    
    
    
    
}
