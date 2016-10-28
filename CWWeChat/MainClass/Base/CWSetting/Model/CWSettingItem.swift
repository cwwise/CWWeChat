//
//  CWSettingItem.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

enum CWSettingItemType {
    case `default`
    case titleButton
    case `switch`
    case other
    
    func reuseIdentifier() -> String {
        switch self {
        case .default:
            return CWSettingCell.reuseIdentifier
        case .titleButton:
            return CWSettingButtonCell.reuseIdentifier
        case .switch:
            return CWSettingSwitchCell.reuseIdentifier
        default:
            return CWSettingCell.reuseIdentifier
        }
    }
}


class CWSettingItem: NSObject {
    ///主标题
    var title: String
    ///副标题
    var subTitle: String?
    
    var rightImagePath: String?
    
    var rightImageURL: String?
    
    var type: CWSettingItemType
    ///是否显示箭头（默认YES）
    var showDisclosureIndicator: Bool
    ///禁止高亮（默认NO）
    var disableHighlight: Bool
    
    init(title: String,subTitle: String? = nil, type: CWSettingItemType = .default) {
        self.title = title
        self.subTitle = subTitle
        self.type = type
        showDisclosureIndicator = true
        disableHighlight = false
        super.init()
    }
    
}
