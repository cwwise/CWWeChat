//
//  CWTableViewSection.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit


///  Table view section.
class CWTableViewSection: NSObject {

    /// 主要内容 (rows)
    var items: [CWTableViewItem]
    
    var headerTitle: String?
    var footerTitle: String?
    
    var headerHeight: Float?
    var footerHeight: Float?

    override init() {
        self.items = [CWTableViewItem]()
        
        super.init()
    }
    
    
    func addItem(item: CWTableViewItem) {
        self.items.append(item)
    }
    
    
}
