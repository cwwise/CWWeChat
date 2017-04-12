//
//  CWButtonItem.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWBoolCellStyle {
    case common
    case commit
}


class CWButtonItem: CWTableViewItem {
    var style: CWBoolCellStyle = .common

    init(title: String, style: CWBoolCellStyle = .common) {
        super.init(title: title)
        self.style = style
    }
}
