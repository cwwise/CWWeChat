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
public let kCWCellLeftMargin: CGFloat = 20
public let kCWDefaultItemCellHeight: CGFloat = 44
public let kCWItemTitleFont = UIFont.systemFont(ofSize: 16)
public let kCWItemsubTitleFont = UIFont.systemFont(ofSize: 15)

public class CWTableViewStyle {
    
    var titleTextColor: UIColor = UIColor.black
    var titleTextFont: UIFont = kCWItemTitleFont

    var detailTextColor: UIColor = UIColor.gray
    var detailTextFont: UIFont = kCWItemTitleFont

    init() {
        
    }
    
}
