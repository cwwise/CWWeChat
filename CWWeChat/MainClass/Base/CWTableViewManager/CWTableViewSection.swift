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
    
    public var headerTitle: String? {
        didSet {
            let width = kScreenWidth - 2*kCWCellLeftMargin
            let attributes = [NSForegroundColorAttributeName:UIColor.white,
                              NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
            headerHeight = CWUIUtility.textHeightOfText(headerTitle, width: width, attributes: attributes) + 0.5 + 5.0
        }
    }
    public var footerTitle: String? {
        didSet {
            let width = kScreenWidth - 2*kCWCellLeftMargin
            let attributes = [NSForegroundColorAttributeName:UIColor.white,
                              NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
            footerHeight = CWUIUtility.textHeightOfText(footerTitle, width: width, attributes: attributes) + 15 + 5.0
        }
    }
    
    public var headerHeight: CGFloat = 0.5
    public var footerHeight: CGFloat = 20.0

    override init() {
        super.init()
    }
    
    //http://www.jianshu.com/p/bf6a8a054156
    convenience init(headerTitle: String? = nil,
                     footerTitle: String? = nil,
                     items: [CWTableViewItem] = [CWTableViewItem]()) {
        self.init()
        
        self.setValue(headerTitle, forKey: "headerTitle")
        self.setValue(footerTitle, forKey: "footerTitle")
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
