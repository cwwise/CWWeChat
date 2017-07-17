//
//  CWMessageFrame.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/17.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

enum CWMessageLayoutItem: Int {
    case avatar
    case username
    case error
    case activity
    case content
}

public struct CWMessageFrame {
    
    /// 文字布局
    var textLayout: YYTextLayout?
    /// cell高度
    var heightOfCell: CGFloat = 0
    /// 内容大小
    var contentSize: CGSize = CGSize.zero
    
    private var allLayoutedRects = [CWMessageLayoutItem: CGRect]()
    
    subscript(item: CWMessageLayoutItem) -> CGRect {
        get {
            return layoutedRect(with: item)
        }
        set {
            allLayoutedRects[item] = newValue
        }
    }
    
    func layoutedRect(with item: CWMessageLayoutItem) -> CGRect {
        return allLayoutedRects[item] ?? .zero
    }
    
}
