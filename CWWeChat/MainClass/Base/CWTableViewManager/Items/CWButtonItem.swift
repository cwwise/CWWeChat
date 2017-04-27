//
//  CWButtonItem.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWButtonCellStyle {
    case common
    case operate(CWButtonType)
}

public enum CWButtonType {
    case normal
    case commit
    case delete
}

class CWButtonItem: CWTableViewItem {
    var style: CWButtonCellStyle = .common

    init(title: String, style: CWButtonCellStyle = .common) {
        super.init(title: title)
        self.style = style
    }
}
