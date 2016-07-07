//
//  CWMoreKeyboardItem.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/7.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMoreKeyboardItem: NSObject {

    var type:CWMoreKeyboardItemType
    var title:String
    var imagePath:String
    
    init(title:String, imagePath:String ,type:CWMoreKeyboardItemType) {
        self.title = title
        self.imagePath = imagePath
        self.type = type
    }
    
}
