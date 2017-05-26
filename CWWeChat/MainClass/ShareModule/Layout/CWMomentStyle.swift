//
//  CWMomentModuleStyle.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

struct CWMomentUI {
    
    static let kTopMargin: CGFloat = 10
    static let kLeftMargin: CGFloat = 10
    /// 头像
    static let kAvatarSize = CGSize(width: 42, height: 42)
    /// 姓名size
    static let kUsernameSize = CGSize(width: 120, height: 20)

    /// 文字
    static let kPaddingText: CGFloat = 10
    static let kContentWidth: CGFloat = kScreenWidth - 2*kLeftMargin - kAvatarSize.width - kPaddingText
    
    // 图片留白
    static let kCellPaddingPic: CGFloat = 5
    // 图片距离
    static let kImageWidth: CGFloat = 80
    static let kImageMaxWidth: CGFloat = 150

    // 颜色
    static let kNameTextColor = UIColor(hex: "#576B95")
    static let kGrayTextColor = UIColor(hex: "#999")
    static let kTextHighlightBackgroundColor = UIColor(hex: "#bfdffe")
}
