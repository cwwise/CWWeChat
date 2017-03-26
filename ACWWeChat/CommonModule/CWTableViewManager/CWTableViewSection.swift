//
//  CWTableViewSection.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit


///  Table view section.
public class CWTableViewSection: NSObject {

    /// 主要内容 (rows)
    public var items: [CWTableViewItem] = [CWTableViewItem]()
    
    public var headerTitle: String = ""
    public var footerTitle: String = ""
    
    public var headerHeight: CGFloat = 0.01
    public var footerHeight: CGFloat = 20.0

    override init() {
        super.init()
    }
    
    convenience init(headerTitle: String = "",
                     footerTitle: String = "",
                     items: [CWTableViewItem] = [CWTableViewItem]()) {
        self.init()
        
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.items = items
    }
    
    
    // 添加
    public func addItem(item: CWTableViewItem) {
        self.items.append(item)
    }
    
    public func addItem(contentsOf items: [CWTableViewItem]) {
        self.items.append(contentsOf: items)
    }
    
    // 待添加验证index
    public subscript(index: Int) -> CWTableViewItem {
        return items[index]
    }
    
    
}
