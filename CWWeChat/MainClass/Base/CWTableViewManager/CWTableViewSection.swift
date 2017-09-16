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
            headerHeight = calculateHeaderTitleHeight()
        }
    }
    
    /// The title of the footer of the specified section of the table view.
    public var footerTitle: String? {
        didSet {
            footerHeight = calculateFooterTitleHeight()
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
    
    // see http://www.jianshu.com/p/bf6a8a054156 swift4.0 中有点问题
    ///
    init(headerTitle: String? = nil,
         footerTitle: String? = nil,
         items: [CWTableViewItem] = [CWTableViewItem]()) {
        super.init()
        
        // TODO: bug in swift4.0 will crash
        // this class is not key value coding-compliant for the key headerTitle.
    //    self.setValue(headerTitle, forKey: "headerTitle")
    //    self.setValue(footerTitle, forKey: "footerTitle")
        self.footerTitle = footerTitle
        self.headerTitle = headerTitle
        // 手动调用计算高度
        headerHeight = calculateHeaderTitleHeight()
        footerHeight = calculateFooterTitleHeight()
        
        for item in items {
            self.addItem(item)
        }
    }
    
    func calculateHeaderTitleHeight() -> CGFloat {
        
        guard let headerTitle = headerTitle else {
            return 15
        }
        
        let width = kScreenWidth - 2*kCWCellLeftMargin
        let attributes = [NSAttributedStringKey.foregroundColor:UIColor.white,
                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let headerHeight = CWUIUtility.textHeightOfText(headerTitle, width: width, attributes: attributes) + 7 + 15
        return headerHeight
    }
    
    func calculateFooterTitleHeight() -> CGFloat {
        
        guard let footerTitle = footerTitle else {
            return 5
        }
        
        let width = kScreenWidth - 2*kCWCellLeftMargin
        let attributes = [NSAttributedStringKey.foregroundColor:UIColor.white,
                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let footerHeight = CWUIUtility.textHeightOfText(footerTitle, width: width, attributes: attributes) + 7 + 5
        return footerHeight
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
