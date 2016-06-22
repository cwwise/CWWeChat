//
//  CWSettingItem.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

enum CWSettingItemType {
    case Default
    case TitleButton
    case Switch
    case Other
    
    func reuseIdentifier() -> String {
        switch self {
        case .Default:
            return CWSettingCell.identifier
        case .TitleButton:
            return CWSettingButtonCell.identifier
        case .Switch:
            return CWSettingSwitchCell.identifier
        default:
            return CWSettingCell.identifier
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
    
    init(title: String,subTitle: String? = nil, type: CWSettingItemType = .Default) {
        self.title = title
        self.subTitle = subTitle
        self.type = type
        showDisclosureIndicator = true
        disableHighlight = false
        super.init()
    }
    
}
