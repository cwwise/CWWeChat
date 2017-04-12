//
//  CWTableViewItem.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

public typealias CWSelectionHandler = (CWTableViewItem) -> ()

/// cell对应的model
public class CWTableViewItem: NSObject {
    
    /// 文本
    public var title: String
    /// 副标题
    public var subTitle: String?
    /// cell高度 默认49
    public var cellHeight: CGFloat = 0.0
    ///  是否显示
    public var showDisclosureIndicator: Bool = true
    ///  是否不高亮
    public var disableHighlight: Bool = false
    
    public var selectionAction: CWSelectionHandler?
    
    public init(title: String, subTitle: String? = nil) {
        self.cellHeight = kCWDefaultItemCellHeight
        self.title = title
        self.subTitle = subTitle
        super.init()
    }
    
}
