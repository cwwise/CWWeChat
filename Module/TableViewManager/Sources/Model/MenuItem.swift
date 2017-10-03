//
//  MenuItem.swift
//  TableViewManager
//
//  Created by wei chen on 2017/10/3.
//

import UIKit

public class MenuItem: Item {
    ///左侧icon路径
    public var iconImageName: String
    ///副图片URL
    public var rightIconURL: String?
    ///是否显示红点
    public var showRightRedPoint: Bool
    
    public init(iconImageName: String, title: String) {
        self.iconImageName = iconImageName
        self.showRightRedPoint = false
        super.init(title: title)
    }
}
