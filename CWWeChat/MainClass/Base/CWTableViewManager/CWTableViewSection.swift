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
    public private(set) var items: [CWTableViewItem] = [CWTableViewItem]()
    
    public weak var tableViewManager: CWTableViewManager?
    
    /// The title of the header of the specified section of the table view.
    public var headerTitle: String? {
        didSet {
            
            guard let headerTitle = self.headerTitle else {
                return
            }
            
            let width = kScreenWidth - 2*kCWCellLeftMargin
            let attributes = [NSAttributedStringKey.foregroundColor:UIColor.white,
                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
            headerHeight = CWUIUtility.textHeightOfText(headerTitle, width: width, attributes: attributes) + 7 + 15
        }
    }
    
    /// The title of the footer of the specified section of the table view.
    public var footerTitle: String? {
        didSet {
            
            guard  let footerTitle = self.footerTitle else {
                return
            }
            
            let width = kScreenWidth - 2*kCWCellLeftMargin
            let attributes = [NSAttributedStringKey.foregroundColor:UIColor.white,
                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
            footerHeight = CWUIUtility.textHeightOfText(footerTitle, width: width, attributes: attributes) + 7 + 5
        }
    }
    
    /// The height of the header of the specified section of the table view.
    public var headerHeight: CGFloat = 15
    /// The height of the footer of the specified section of the table view.
    public var footerHeight: CGFloat = 5
    /// The width of padding between the cell title and cell detail view
    public var cellTitlePadding: CGFloat = 20
    
    public var index: Int? {
        return tableViewManager?.sections.index(of: self)
    }
    
    // see http://www.jianshu.com/p/bf6a8a054156
    ///
    init(headerTitle: String? = nil,
                     footerTitle: String? = nil,
                     items: [CWTableViewItem] = [CWTableViewItem]()) {
        super.init()
        self.setValue(headerTitle, forKey: "headerTitle")
        self.setValue(footerTitle, forKey: "footerTitle")
        for item in items {
            self.addItem(item)
        }
    }
    
    // 添加
    public func addItem(_ item: CWTableViewItem) {
        item.section = self
        self.items.append(item)
    }
    
    public func addItem(contentsOf items: [CWTableViewItem]) {
        for item in items {
            self.addItem(item)
        }
    }
    
    // 待添加验证index
    public subscript(index: Int) -> CWTableViewItem {
        return items[index]
    }
    
    
}
