//
//  Section.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

public class Section: NSObject {

    /// 主要内容 (rows)
    public private(set) var items: [Item] = [Item]()
    
    public weak var tableViewManager: TableViewManager?
    
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
    
    public var headerHeight: CGFloat = 15

    public var footerHeight: CGFloat = 5

    public var count: Int {
        return items.count
    }
    
    public var index: Int? {
        return tableViewManager?.sections.index(of: self)
    }
    
    public init(headerTitle: String? = nil,
         footerTitle: String? = nil,
         items: [Item] = [Item]()) {
        super.init()
        
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
        
        guard let headerTitle = headerTitle,
            let tableViewManager = tableViewManager,
            let tableView = tableViewManager.tableView else {
            return 15
        }
        
        let width = tableView.bounds.width - 2*kCellLeftMargin
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let headerHeight = textHeightOfText(headerTitle, width: width, attributes: attributes)  + 7 + 15
        return headerHeight
    }
    
    func calculateFooterTitleHeight() -> CGFloat {
                
        guard let footerTitle = footerTitle,
            let tableViewManager = tableViewManager,
            let tableView = tableViewManager.tableView else {
                return 5
        }
        
        let width = tableView.bounds.width - 2*kCellLeftMargin
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let footerHeight = textHeightOfText(footerTitle, width: width, attributes: attributes) + 7 + 5
        return footerHeight
    }
    
    // 添加
    public func addItem(_ item: Item) {
        item.section = self
        self.items.append(item)
    }
    
    public func addItem(contentsOf items: [Item]) {
        for item in items {
            self.addItem(item)
        }
    }
    
    // 待添加验证index
    public subscript(index: Int) -> Item {
        return items[index]
    }
    
}
