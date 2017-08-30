//
//  MoreItem.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

///键盘相关的枚举
public enum MoreItemType: Int {
    case image
    case camera
    case video
    case videoCall
    case wallet
    case transfer
    case position
    case favorite
    case businessCard
    case voice
    case cards
}


class MoreItem: NSObject {

    public var type: MoreItemType
    public var title: String
    public var imagePath: String
    
    public init(title:String,
                imagePath:String,
                type:MoreItemType) {
        self.title = title
        self.imagePath = imagePath
        self.type = type
    }
    
}
