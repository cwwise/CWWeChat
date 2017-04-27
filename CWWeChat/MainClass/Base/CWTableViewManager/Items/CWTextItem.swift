//
//  CWTextItem.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/27.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWTextCellStyle {
    case common
    case detail
}

class CWTextItem: CWTableViewItem {

    var detailText: String
    var style: CWTextCellStyle = .common
    
    init(title: String, detailText: String, style: CWTextCellStyle = .common) {
        self.detailText = detailText
        self.style = style
        super.init(title: title)
    }
    
}
