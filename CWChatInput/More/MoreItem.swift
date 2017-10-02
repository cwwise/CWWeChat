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
    case location
    case favorite
    case businessCard
    case voice
    case cards
}


public class MoreItem: NSObject {

    public var type: MoreItemType
    public var title: String
    public var imagename: String
    
    public init(title:String,
                imagename:String,
                type:MoreItemType) {
        self.title = title
        self.imagename = imagename
        self.type = type
    }
    
}
