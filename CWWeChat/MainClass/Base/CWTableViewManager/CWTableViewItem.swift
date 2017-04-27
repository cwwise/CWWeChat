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
    
    public weak var section: CWTableViewSection?
    /// 文本
    public var title: String
    /// 副标题
    public var subTitle: String?
    /// cell高度 默认49
    public var cellHeight: CGFloat = 0.0
    /// 图标的URL
    public var rightImageURL: URL?
    
    ///  是否显示
    public var showDisclosureIndicator: Bool = true
    ///  是否不高亮
    public var disableHighlight: Bool = false
    
    public var selectionAction: CWSelectionHandler?
    
    public var indexPath: IndexPath? {
        guard let index = section?.items.index(of: self),
            let section_index = section?.index else {
                return nil
        }
        return IndexPath(row: index, section: section_index)
    }
    
    public init(title: String, 
                subTitle: String? = nil,
                rightImageURL: URL? = nil) {
        self.cellHeight = kCWDefaultItemCellHeight
        self.title = title
        self.subTitle = subTitle
        super.init()
    }
    
}
