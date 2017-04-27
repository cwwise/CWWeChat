//
//  CWTableViewStyle.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation
import UIKit

public struct CWTableViewUI {
    
}

// 样式文件
let kCWCellLeftMargin: CGFloat = 20
let kCWDefaultItemCellHeight: CGFloat = 44
let kCWItemTitleFont = UIFont.systemFont(ofSize: 16)
let kCWItemsubTitleFont = UIFont.systemFont(ofSize: 15)


public class CWTableViewStyle {
    
    var titleTextColor: UIColor = UIColor.black
    var titleTextFont: UIFont = kCWItemTitleFont

    var detailTextColor: UIColor = UIColor.gray
    var detailTextFont: UIFont = kCWItemTitleFont

    init() {
        
    }
    
}
