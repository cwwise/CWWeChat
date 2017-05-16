//
//  CWMoreKeyboardItem.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public class CWMoreItem: NSObject {
    
    public var type: CWMoreItemType
    public var title: String
    public var imagePath: String
    
    public init(title:String,
         imagePath:String,
         type:CWMoreItemType) {
        self.title = title
        self.imagePath = imagePath
        self.type = type
    }
    
}
