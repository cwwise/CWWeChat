//
//  CWBoolItem.swift
//  CWWeChat
//
//  Created by chenwei on 2017/2/12.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

class CWBoolItem: CWTableViewItem {
    
    public var value: Bool = false
    public var switchValueChangeHandler: CWSelectionHandler?
    
    init(title: String, value: Bool = false) {
        super.init(title: title)
        self.value = value
        self.disableHighlight = true
    }
    
}
