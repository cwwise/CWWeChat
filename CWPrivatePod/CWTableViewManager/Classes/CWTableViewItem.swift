//
//  CWTableViewItem.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit


/// cell对应的model
class CWTableViewItem: NSObject {
    
    var title: String
    /// cell高度
    var cellHeight: Float
    
    init(title: String) {
        cellHeight = 49
        self.title = title
        super.init()
    }
    
}
